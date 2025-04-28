
# This Terraform configuration creates an AWS Lambda function with a specified IAM role and policy attachment.
# It also includes a local file provisioner to package the Lambda function code.
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# This policy allows the Lambda function to write logs to CloudWatch
# and is necessary for monitoring and debugging.
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# This local file provisioner is used to package the Lambda function code
# into a zip file before deployment. Ensure the lambda_function.py file exists in the same directory.
resource "aws_lambda_function" "my_lambda" {
  function_name = "my_lambda_function"
  role          =  aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
  timeout       = 500
  memory_size   = 128

  filename         = "lambda_function.zip"  # Ensure this file exists
  source_code_hash = filebase64sha256("lambda_function.zip")
}

# (Optional) Output Lambda ARN
output "lambda_function_arn" {
  value = aws_lambda_function.my_lambda.arn
}