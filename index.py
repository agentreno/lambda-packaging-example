import pyjokes


def lambda_handler(event, context):
    return pyjokes.get_joke()
