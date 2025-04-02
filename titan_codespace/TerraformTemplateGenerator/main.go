package main

import (
	"context"
	"fmt"
	"io"
	"os"
	"strings"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/s3"
)

type Event struct {
	Bucket     string   `json:"bucket"`
	Prefixs    []string `json:"prefixs"`
	PathToPush string   `json:"pathToPush"`
}

type BucketBasics struct {
	S3Client *s3.Client
}

var bucketBasics BucketBasics

func init() {
	cfg, err := config.LoadDefaultConfig(context.TODO())
	if err != nil {
		panic(fmt.Sprintf("unable to load SDK config, %v", err))
	}
	bucketBasics = BucketBasics{
		S3Client: s3.NewFromConfig(cfg),
	}
	fmt.Println("AWS S3 client initialized successfully!")
}

func (basics BucketBasics) handler(ctx context.Context, event Event) (string, error) {
	var sb strings.Builder
	for _, prefixs := range event.Prefixs {
		result, err := basics.S3Client.ListObjectsV2(ctx, &s3.ListObjectsV2Input{
			Bucket: &event.Bucket,
			Prefix: &prefixs,
		})
		if err != nil {
			return "", fmt.Errorf("failed to list objects: %v", err)
		}
		for _, objects := range result.Contents {
			if err := basics.appendingContent(ctx, &sb, event.Bucket, *objects.Key); err != nil {
				return "", fmt.Errorf("failed to append content: %v", err)
			}
		}
	}

	// Write content to a local file
	localFile := "/tmp/main.tf"
	if err := os.WriteFile(localFile, []byte(sb.String()), 0644); err != nil {
		return "", fmt.Errorf("failed to write to file: %w", err)
	}

	if err := basics.pushToPath(ctx, localFile, event.Bucket, event.PathToPush); err != nil {
		return "", fmt.Errorf("failed to push to path: %w", err)
	}

	return "SuccessfullyPushed", nil
}

func (basics BucketBasics) appendingContent(ctx context.Context, sb *strings.Builder, bucket, key string) error {
	getObjectOutput, err := basics.S3Client.GetObject(ctx, &s3.GetObjectInput{
		Bucket: &bucket,
		Key:    &key,
	})
	if err != nil {
		return fmt.Errorf("failed to get object: %v", err)
	}
	defer getObjectOutput.Body.Close()
	if _, err := io.Copy(sb, getObjectOutput.Body); err != nil {
		return fmt.Errorf("failed to read object %s: %w", key, err)
	}
	sb.WriteString("\n")

	return nil
}

func (basics BucketBasics) pushToPath(ctx context.Context, localFile string, bucket, key string) error {
	// Read the local file
	file, err := os.Open(localFile)
	if err != nil {
		return fmt.Errorf("failed to open local file: %w", err)
	}
	_, err = basics.S3Client.PutObject(ctx, &s3.PutObjectInput{
		Bucket:      &bucket,
		Key:         &key,
		ContentType: aws.String("text/plain"),
		Body:        file,
	})
	if err != nil {
		return fmt.Errorf("failed to upload file to S3: %w", err)
	}
	return nil
}

func main() {
	lambda.Start(bucketBasics.handler)
}
