from aws_cdk import (
    aws_lambda as _lambda,
    aws_lambda_python as _lambda_python,
    core
)


class ToyCdkStack(core.Stack):

    def __init__(self, scope: core.Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        my_python_lambda = _lambda_python.PythonFunction(
            self,
            'MyPythonLambda',
            runtime=_lambda.Runtime.PYTHON_3_8,
            entry = '/opt/toy-cdk/lambda/'
        )
