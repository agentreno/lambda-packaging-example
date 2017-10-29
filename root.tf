variable "region" {
    type = "string"
    default = "eu-west-1"
}

# Uses ~/.aws/credentials, default env uses staging profile
provider "aws" {
    region = "${var.region}"
    profile = "${terraform.env == "default" ? "staging" : terraform.env}"
}

resource "aws_s3_bucket" "package_bucket" {
    bucket= "packaging-test-lambda-packages"
    acl = "private"
}

resource "aws_s3_bucket_object" "packaging_test_package" {
    bucket = "${aws_s3_bucket.package_bucket.bucket}"
    key = "package.zip"
    source = "package.zip"
}

# IAM Roles and Policies
resource "aws_iam_role" "packaging_test_lambda_role" {
    name = "packaging_test_lambda_role"
    assume_role_policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Action": "sts:AssumeRole",
			"Principal": {
				"Service": "lambda.amazonaws.com"
			},
			"Effect": "Allow"
		}
	]
}
EOF
}
 
resource "aws_iam_role_policy_attachment" "packaging_test_basic_role_attachment" {
	role = "${aws_iam_role.packaging_test_lambda_role.id}"
	policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda function
resource "aws_lambda_function" "package_test" {
    description = "Testing function for lambda package creation and deployment"
    s3_bucket = "${aws_s3_bucket.package_bucket.bucket}"
    s3_key = "${aws_s3_bucket_object.packaging_test_package.key}"
    function_name = "package_test"
    handler = "index.lambda_handler"
    memory_size = "128"
    role = "${aws_iam_role.packaging_test_lambda_role.arn}"
    runtime = "python3.6"
    timeout = "5"
}

