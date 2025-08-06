from ETL.etl import transform_log_data

def test_transform_log_data():
    input_data = [
        {"event_id": "e1", "timestamp": "2023-01-01T00:00:00Z"},
        {"event_id": "e2", "timestamp": "2023-01-01T01:00:00Z", "user_id": "userX"},
        {"timestamp": "2023-01-01T02:00:00Z"}
    ]
    expected = [
        {"event_id": "e1", "timestamp": "2023-01-01T00:00:00Z", "user_id": "unknown"},
        {"event_id": "e2", "timestamp": "2023-01-01T01:00:00Z", "user_id": "userX"}
    ]
    assert transform_log_data(input_data) == expected
