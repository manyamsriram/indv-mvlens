data "archive_file" "lambda" {
  type        = "zip"
  source_file = "/Users/srirammanyam/Desktop/AWS/Projects/data_ingestion_project/source/ingestion_lamda_function_raw/ingestion-raw.py"
  output_path = "/Users/srirammanyam/Desktop/AWS/Projects/data_ingestion_project/source/ingestion_lamda_function_raw/ingestion-raw.zip"
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = data.archive_file.lambda.output_path
  function_name = "ingest-source-raw-data-raw_tf"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "ingestion-raw.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.10"
  environment {
    variables = {
      bucket_config = "movielensdatasource"
    }
  }

}

