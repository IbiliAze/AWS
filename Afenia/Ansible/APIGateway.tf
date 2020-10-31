resource "aws_api_gateway_rest_api" "AfeniaAPI" {
  name        			= "AfeniaAPI"
  description 			= "Front-end API for HTTPS requests"
  endpoint_configuration {
    types 			= ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "ConfigResource" {
  rest_api_id 			= aws_api_gateway_rest_api.AfeniaAPI.id
  parent_id   			= aws_api_gateway_rest_api.AfeniaAPI.root_resource_id
  path_part   			= "config"
}

resource "aws_api_gateway_method" "ConfigPOSTMethod" {
  rest_api_id   		= aws_api_gateway_rest_api.AfeniaAPI.id
  resource_id   		= aws_api_gateway_resource.ConfigResource.id
  http_method   		= "POST"
  authorization 		= "NONE"
}

resource "aws_api_gateway_integration" "LambdaProxyIntegration" {
  rest_api_id             	= aws_api_gateway_rest_api.AfeniaAPI.id
  resource_id             	= aws_api_gateway_resource.ConfigResource.id
  http_method             	= aws_api_gateway_method.ConfigPOSTMethod.http_method
  integration_http_method 	= "POST"
  type                    	= "AWS_PROXY"
  uri                     	= aws_lambda_function.API.invoke_arn
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id			= "AllowExecutionFromAPIGateway"
  action        		= "lambda:InvokeFunction"
  function_name 		= aws_lambda_function.API.function_name
  principal     		= "apigateway.amazonaws.com"
  source_arn 			= "arn:aws:execute-api:${var.AWS_REGION}:${var.accountId}:${aws_api_gateway_rest_api.AfeniaAPI.id}/*/${aws_api_gateway_method.ConfigPOSTMethod.http_method}${aws_api_gateway_resource.ConfigResource.path}"
}
