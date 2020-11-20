resource "aws_lambda_function" "AfeniaAPI" {
  filename      	= "LambdaFunctions/API/lambda.zip"
  function_name 	= "API"
  role         		= aws_iam_role.AfeniaLambdaRole.arn
  handler       	= "lambda_function.lambda_handler"
  runtime 		= "python3.8"
}


resource "aws_lambda_function" "AfeniaConfigtoJSON" {
  filename      	= "LambdaFunctions/ConfigJSON/lambda.zip"
  function_name 	= "AfeniaConfigJSON"
  role         		= aws_iam_role.AfeniaLambdaRole.arn
  handler       	= "lambda_function.lambda_handler"
  runtime 		= "python3.8"
}


resource "aws_lambda_function" "AfeniaJSONtoAnsible" {
  filename      	= "LambdaFunctions/JSONAnsible/lambda.zip"
  function_name 	= "AfeniaJSONAnsible"
  role         		= aws_iam_role.AfeniaLambdaRole.arn
  handler       	= "lambda_function.lambda_handler"
  runtime 		= "python3.8"
}
