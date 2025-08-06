import pytest
from ETL.etl import transform_log_data


def test_transform_log_data():
    """Test the main ETL function with basic scenarios"""
    input_data = [
        {"event_id": "e1", "timestamp": "2023-01-01T00:00:00Z"},
        {"event_id": "e2", "timestamp": "2023-01-01T01:00:00Z", "user_id": "userX"},
        {"timestamp": "2023-01-01T02:00:00Z"}  # Missing event_id
    ]
    expected = [
        {"event_id": "e1", "timestamp": "2023-01-01T00:00:00Z", "user_id": "unknown"},
        {"event_id": "e2", "timestamp": "2023-01-01T01:00:00Z", "user_id": "userX"}
    ]
    assert transform_log_data(input_data) == expected

def test_empty_input():
    """Test with empty input"""
    assert transform_log_data([]) == []

def test_valid_data():
    """Test with valid data"""
    input_data = [
        {"event_id": "e1", "timestamp": "2023-01-01T00:00:00Z", "user_id": "user1"},
        {"event_id": "e2", "timestamp": "2023-01-01T01:00:00Z", "user_id": "user2"}
    ]
    result = transform_log_data(input_data)
    assert len(result) == 2
    assert all("event_id" in entry and "timestamp" in entry and "user_id" in entry for entry in result)
