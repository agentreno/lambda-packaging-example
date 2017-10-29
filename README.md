# lambda-packaging-example

Example code for packaging a python Lambda function. Demonstrates the exclusion
of unwanted code from the package e.g. wheel, setuptools, pip.

1. Create a virtualenv, preferably matching the python version used on AWS:
   `virtualenv -p python3.6 env`

2. Install the requirements: `pip install -r requirements.txt`

3. Optionally use terraform to create the function, IAM role and policy,
   supporting S3 bucket and object.  Defaults to the `staging` AWS profile in
   your credentials file. Run `terraform init`, `terraform plan` and `terraform
   apply`.

4. Run the build and deploy scripts. It uploads quicker and the code can be
   previewed in the AWS dashboard.

5. Run the function and see a funny.
