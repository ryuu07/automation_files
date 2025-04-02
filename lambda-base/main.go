package main

import (
	"context"

	"github.com/aws/aws-lambda-go/lambda"
	"go.uber.org/zap"
)

var logger *zap.Logger

func init() {
	// Initialize the package if needed
	l, _ := zap.NewProduction()
	logger = l
	defer logger.Sync()

}

type Event struct {
	Name string `json:"name"`
}

func MyHandler(ctx context.Context, event Event) error {
	// Add your handler logic here
	logger.Info("Lambda function invoked", zap.Any("event", event))
	return nil
}

func main() {
	lambda.Start(MyHandler)
}
