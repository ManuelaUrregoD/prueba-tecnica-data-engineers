import requests
import json
from datetime import datetime, timedelta

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

if __name__ == "__main__":
    fetch_tv_shows_data()   