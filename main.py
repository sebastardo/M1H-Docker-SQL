#!/usr/bin/env python
# coding: utf-8

import pandas as pd
from sqlalchemy import create_engine
import click


@click.command()
@click.option('--host', default='localhost', help='PostgreSQL host')
@click.option('--port', default=5433, type=int, help='PostgreSQL port')
def main(host, port):
    engine = create_engine(f"postgresql://psql:postgres@{host}:{port}/ny_taxi")



    df_trips = pd.read_parquet("data/green_tripdata_2025-11.parquet", engine="pyarrow")
    
    df_trips.to_sql(name="trip_data", con=engine, if_exists="replace")

    dtypes_zones = {
        "LocationID": "Int64",
        "Borough": "category",
        "Zone": "string",
        "service_zone": "category",
    }

    df_zones = pd.read_csv("data/taxi_zone_lookup.csv", dtype=dtypes_zones)
    df_zones = df_zones.set_index("LocationID")
    df_zones.to_sql(
        name="zones",
        con=engine,
        index=True,
        index_label="LocationID",
        if_exists="replace",
    )


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"Error: {e}")