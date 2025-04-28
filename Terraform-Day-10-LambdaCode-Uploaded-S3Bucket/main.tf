# S3 Bucket to Store Lambda Code
resource "aws_s3_bucket" "lambda_bucket" {
  bucket        = "buyoobuy.com" # Ensure this bucket name is globally unique
  acl           = "private"
  force_destroy = true

  tags = {
    Name = "LambdaBucket"
  }
}

# Upload Lambda Code to S3
resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.lambda_bucket.id
  key    = "lambda_function.zip"
  source = "lambda_function.zip" # Path to your zip file containing the Lambda code
  etag   = filemd5("lambda_function.zip")
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach Policy to IAM Role
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda Function
resource "aws_lambda_function" "my_lambda" {
  function_name    = "my_lambda_function"
  runtime          = "python3.9"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "lambda_function.lambda_handler" # Replace with your function handler
  s3_bucket        = aws_s3_bucket.lambda_bucket.id # calling code from s3 bucket 
  s3_key           = aws_s3_object.lambda_code.key # inside this folder
  timeout          = 500
  memory_size      = 128

  environment {
    variables = {
      ENV_VAR_KEY = "ENV_VAR_VALUE" # Example environment variable
    }
  }

  tags = {
    Name = "MyLambdaFunction"
  }
}



# API Gateway Trigger for Lambda
# Create an API Gateway to trigger the Lambda function
resource "aws_apigatewayv2_api" "api_gateway" {
  name          = "MyLambdaAPI"
  protocol_type = "HTTP"
}

# Create a deployment for the API Gateway
resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api_gateway.execution_arn}/*/*"
}

# Create an integration between API Gateway and Lambda
# This integration allows API Gateway to invoke the Lambda function
resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.api_gateway.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.my_lambda.invoke_arn
  payload_format_version = "2.0"
}

# Create a route for the API Gateway
# This route defines how the API Gateway will handle incoming requests
resource "aws_apigatewayv2_route" "default_route" {
  api_id    = aws_apigatewayv2_api.api_gateway.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

# Create a stage for the API Gateway
# This stage is where the API is deployed and can be accessed
resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.api_gateway.id
  name        = "$default"
  auto_deploy = true
}
