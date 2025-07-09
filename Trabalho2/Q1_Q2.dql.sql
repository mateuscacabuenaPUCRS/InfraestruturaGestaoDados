CREATE KEYSPACE IF NOT EXISTS passengers
WITH REPLICATION = {
    'class' : 'SimpleStrategy',
    'replication_factor' : 1
}
AND DURABLE_WRITES = FALSE;
-- DROP KEYSPACE IF EXISTS passengers;

USE passengers;

CREATE TABLE passengers_by_lastname (
    lastname TEXT,
    passenger_id INT,
    firstname TEXT,
    country TEXT,
    city TEXT,
    PRIMARY KEY (lastname)
);

CREATE TABLE passengers_lastname_countries_by_seat (
    lastname TEXT,
    passenger_id INT,
    country TEXT,
    seat_no TEXT,
    PRIMARY KEY ((lastname), seat_no, country)
);

-- ---------------

CREATE KEYSPACE IF NOT EXISTS airports
WITH REPLICATION = {
    'class' : 'SimpleStrategy',
    'replication_factor' : 1
}
AND DURABLE_WRITES = FALSE;
-- DROP KEYSPACE IF EXISTS airports;

USE airports;

CREATE TABLE airports_by_name (
    name TEXT,
    airport_id INT,
    icao TEXT,
    iata TEXT,
    city TEXT,
    country TEXT,
    PRIMARY KEY (name),
);

CREATE TABLE airlines_by_city (
    airline_id INT,
    city TEXT,
    iata TEXT,
    airline_name TEXT,
    PRIMARY KEY ((airline_id), city)
);

-- --------------

CREATE KEYSPACE IF NOT EXISTS airplanes
WITH REPLICATION = {
    'class' : 'SimpleStrategy',
    'replication_factor' : 1
}
AND DURABLE_WRITES = FALSE;
-- DROP KEYSPACE IF EXISTS airplanes;

USE airplanes;

CREATE TABLE airplanes_by_type (
    airplane_type TEXT,
    airplane_id INT,
    capacity INT,
    PRIMARY KEY (airplane_type),
);

CREATE TABLE flights_by_airplane_type (
    flight_id INT,
    airplane_type TEXT,
    flight_no TEXT,
    PRIMARY KEY ((flight_id), airplane_type)
);

DROP TABLE flights_by_airplane_type;