resource "aws_api_gateway_rest_api" "AfeniaAPI" {
  name        		= "AfeniaAPI"
  description 		= "Front-end API for HTTPS requests"
  endpoint_configuration {
    types 		= ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "ConfigResource" {
  rest_api_id 		= aws_api_gateway_rest_api.AfeniaAPI.id
  parent_id   		= aws_api_gateway_rest_api.AfeniaAPI.root_resource_id
  path_part   		= "config"
}

resource "aws_api_gateway_method" "ConfigPOSTMethod" {
  rest_api_id   	= aws_api_gateway_rest_api.AfeniaAPI.id
  resource_id   	= aws_api_gateway_resource.ConfigResource.id
  http_method   	= "POST"
  authorization 	= "NONE"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.myregion}:${var.accountId}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.resource.path}"
}
