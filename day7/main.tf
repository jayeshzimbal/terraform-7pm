# S3 Bucket

resource "aws_s3_bucket" "lambda_code" {
  bucket = "jayeshzimbal"
}



# IAM Role

resource "aws_iam_role" "lambda_role" {
  name = "jayesh"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}


resource "aws_iam_policy" "lambda_custom_policy" {
  name        = "jayesh-lambda-policy"
  description = "Custom policy for Lambda logs and S3 read"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject"
        ]
        Resource = "${aws_s3_bucket.lambda_code.arn}/*"
      }
    ]
  })
}




resource "aws_iam_role_policy_attachment" "lambda_custom_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_custom_policy.arn
}


# Lambda 

resource "aws_lambda_function" "demo_lambda" {
  function_name = "aaba-custom-iam-lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"

  s3_bucket = aws_s3_bucket.lambda_code.bucket
  s3_key    = "lambda_code.py.zip"

  depends_on = [
    aws_iam_role_policy_attachment.lambda_custom_attach
  ]
}
