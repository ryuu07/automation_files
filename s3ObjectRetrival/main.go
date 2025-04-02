package main

import (
	"context"
	"fmt"
	"io"

	// "log"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/s3"
)

type BucketBasics struct {
	S3Client *s3.Client
}

// Event represents the structure of the event data
type Event struct {
	Bucket string `json:"bucket"`
	Key    string `json:"key"`
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
	fmt.Println("✅ AWS S3 client initialized successfully!")
}

func (basics BucketBasics) MyHandler(ctx context.Context, event Event) (string, error) {
	result, err := basics.S3Client.GetObject(ctx, &s3.GetObjectInput{
		Bucket: &event.Bucket,
		Key:    &event.Key,
	})
	if err != nil {
		return "", fmt.Errorf("failed to get object from S3: %w", err)
	}
	defer result.Body.Close()
	body, err := io.ReadAll(result.Body)
	if err != nil {
		return "", fmt.Errorf("failed to read object body: %w", err)

	}
	return string(body), nil
}

func main() {
	lambda.Start(bucketBasics.MyHandler)
}
