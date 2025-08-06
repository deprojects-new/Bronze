import json


def transform_log_data(log_data: list) -> list:
    """
    Transforms raw log data by parsing timestamps and filtering invalid entries.
    """
    clean_data = []
    for entry in log_data:
        try:
            if "event_id" in entry and "timestamp" in entry:
                clean_data.append(
                    {
                        "event_id": entry["event_id"],
                        "timestamp": entry["timestamp"],
                        "user_id": entry.get("user_id", "unknown"),
                    }
                )
        except Exception as e:
            print(f"Error parsing entry: {entry} — {e}")
    return clean_data


if __name__ == "__main__":
    # Dummy test
    sample_logs = [
        {"event_id": "abc123", "timestamp": "2023-01-01T10:00:00Z", "user_id": "user1"},
        {"event_id": "xyz789", "timestamp": "2023-01-01T11:00:00Z"},
    ]
    transformed = transform_log_data(sample_logs)
    print(json.dumps(transformed, indent=2))
