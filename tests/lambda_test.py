import pytest
import json
from unittest.mock import Mock, patch
from lambdafn.lambdafn import lambda_handler


def test_lambda_handler():
    """Test the main Lambda function"""
    event = {"key": "value", "message": "test"}
    context = None
    
    result = lambda_handler(event, context)
    
    assert result["statusCode"] == 200
    assert "Hello from Lambda!" in result["body"]

def test_empty_event():
    """Test with empty event"""
    event = {}
    context = None
    
    result = lambda_handler(event, context)
    
    assert result["statusCode"] == 200
    assert "Hello from Lambda!" in result["body"]

def test_s3_event():
    """Test with S3 event"""
    event = {
        "Records": [
            {
                "eventSource": "aws:s3",
                "s3": {
                    "bucket": {"name": "test-bucket"},
                    "object": {"key": "test-file.txt"}
                }
            }
        ]
    }
    context = None
    
    result = lambda_handler(event, context)
    
    assert result["statusCode"] == 200
    assert "Hello from Lambda!" in result["body"]
