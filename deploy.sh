aws s3 cp package.zip s3://packaging-test-lambda-packages/package.zip

aws lambda update-function-code \
    --function-name package_test \
    --s3-bucket packaging-test-lambda-packages \
    --s3-key package.zip
