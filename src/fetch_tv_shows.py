import requests
import json
from datetime import datetime, timedelta
import pandas as pd
import os

def get_series_data(date):
    url = f"http://api.tvmaze.com/schedule/web?date={date}"
    try:
        response = requests.get(url)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"Error al obtener los datos de la fecha {date}: {e}")
        return []

def fetch_tv_shows_data():
    start_date = datetime(2024, 1, 1)
    end_date = datetime(2024, 1, 31)
    
    all_data = [
        series
        for i in range((end_date - start_date).days + 1)
        for series in get_series_data((start_date + timedelta(days=i)).strftime('%Y-%m-%d'))
    ]

    for i in range((end_date - start_date).days + 1):
        date = (start_date + timedelta(days=i)).strftime('%Y-%m-%d')
        daily_data = get_series_data(date)
        with open(f"../json/data_{date}.json", "w") as file:
            json.dump(daily_data, file, indent=4)

    return all_data

def load_json_to_pandas_dataframe(json_folder="../json/"):
    all_files = [os.path.join(json_folder, file) for file in os.listdir(json_folder) if file.endswith(".json")]
    all_data = []
    for file in all_files:
        with open(file, 'r') as f:
            data = json.load(f)
            all_data.extend(data)
    
    df = pd.json_normalize(all_data)
    return df

