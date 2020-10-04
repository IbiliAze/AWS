resource "aws_lambda_function" "AfeniaAPI" {
  filename      	= "LambdaFunctions/API/lambda.zip"
  function_name 	= "AfeniaAPI"
  role         		= aws_iam_role.AfeniaLambdaRole.arn
  handler       	= "lambda_function.lambda_handler"
  runtime 		= "python3.8"
}


resource "aws_lambda_function" "AfeniaConfigtoJSON" {
  filename      	= "LambdaFunctions/ConfigtoJSON/lambda.zip"
  function_name 	= "AfeniaConfigtoJSON"
  role         		= aws_iam_role.AfeniaLambdaRole.arn
  handler       	= "lambda_function.lambda_handler"
  runtime 		= "python3.8"
}


resource "aws_lambda_function" "AfeniaJSONtoAnsible" {
  filename      	= "LambdaFunctions/JSONtoAnsible/lambda.zip"
  function_name 	= "AfeniaJSONtoAnsible"
  role         		= aws_iam_role.AfeniaLambdaRole.arn
  handler       	= "lambda_function.lambda_handler"
  runtime 		= "python3.8"
}
