SELECT DISTINCT
    'INSERT INTO passengers.passengers_by_lastname (lastname, passenger_id, firstname, country, city) VALUES (' ||
    '''' || TRIM(passenger.lastname) || ''', ' ||
    passenger.passenger_id || ', ' ||
    '''' || TRIM(passenger.firstname) || ''', ' ||
    '''' || TRIM(passengerDetails.country) || ''', ' ||
    '''' || TRIM(passengerDetails.city) || ''');'
FROM
    ACAMPOS.AIR_PASSENGERS passenger
        JOIN ACAMPOS.AIR_PASSENGERS_DETAILS passengerDetails
            ON passenger.passenger_id = passengerDetails.passenger_id
;

SELECT DISTINCT
    'INSERT INTO passengers.passengers_lastname_countries_by_seat (lastname, passenger_id, country, seat_no) VALUES (' ||
    '''' || TRIM(passenger.lastname) || ''', ' ||
    passenger.passenger_id || ', ' ||
    '''' || TRIM(passengerDetails.country) || ''', ' ||
    '''' || TRIM(booking.seat) || ''');'
FROM
    ACAMPOS.AIR_PASSENGERS passenger
        JOIN ACAMPOS.AIR_PASSENGERS_DETAILS passengerDetails
            ON passenger.passenger_id = passengerDetails.passenger_id
        JOIN ACAMPOS.AIR_BOOKINGS booking
            ON passenger.passenger_id = booking.passenger_id
;

-- -----------

SELECT DISTINCT
    'INSERT INTO airports.airports_by_name (name, airport_id, icao, iata, city, country) VALUES (' ||
    '''' || TRIM(airport.name) || ''', ' ||
    airport.airport_id || ', ' ||
    '''' || TRIM(airport.icao) || ''', ' ||
    '''' || TRIM(airport.iata) || ''', ' ||
    '''' || TRIM(airportGeography.city) || ''', ' ||
    '''' || TRIM(airportGeography.country) || ''');'
FROM
    ACAMPOS.AIR_AIRPORTS airport
        JOIN ACAMPOS.AIR_AIRPORTS_GEO airportGeography
            ON airport.airport_id = airportGeography.airport_id
;

SELECT DISTINCT
    'INSERT INTO airports.airlines_by_city (airline_id, city, iata, airline_name) VALUES (' ||
    airline.airline_id || ', ' ||
    '''' || TRIM(airportGeography.city) || ''', ' ||
    '''' || TRIM(airline.iata) || ''', ' ||
    '''' || TRIM(airline.airline_name) || ''');'
FROM
    ACAMPOS.AIR_AIRPORTS airport
        JOIN ACAMPOS.AIR_AIRPORTS_GEO airportGeography
            ON airport.airport_id = airportGeography.airport_id
        JOIN ACAMPOS.AIR_AIRLINES airline
            ON airport.airport_id = airline.base_airport_id
;

-- ---------

SELECT DISTINCT
    'INSERT INTO airplanes.airplanes_by_type (airplane_type, airplane_id, capacity) VALUES (' ||
    '''' || TRIM(airplaneType.name) || ''', ' ||
    airplane.airplane_id || ', ' ||
    airplane.capacity || ');'
FROM
    ACAMPOS.AIR_AIRPLANES airplane
        JOIN ACAMPOS.AIR_AIRPLANE_TYPES airplaneType
            ON airplane.airplane_type_id = airplaneType.airplane_type_id
;

SELECT DISTINCT
    'INSERT INTO airplanes.flights_by_airplane_type (flight_id, airplane_type, flight_no) VALUES (' ||
    flight.flight_id || ', ' ||
    '''' || TRIM(airplaneType.name) || ''', ' ||
    '''' || TRIM(flight.flightno) || ');'
FROM
    ACAMPOS.AIR_FLIGHTS flight
        JOIN ACAMPOS.AIR_AIRPLANES airplane
            ON flight.airplane_id = airplane.airplane_id
        JOIN ACAMPOS.AIR_AIRPLANE_TYPES airplaneType
            ON airplane.airplane_type_id = airplaneType.airplane_type_id
;


USE passengers;

SELECT passenger_id, firstname, lastname
FROM passengers_by_lastname
WHERE lastname = 'Maestro';

SELECT passenger_id, country, seat_no
FROM passengers_lastname_countries_by_seat
WHERE lastname = 'Maestro';

USE airports;

SELECT airport_id, name, icao, iata, city, country
FROM airports_by_name
WHERE city = 'TAIPEI' ALLOW FILTERING;

SELECT airline_id, airline_name
FROM airlines_by_city
WHERE city = 'TAIPEI' ALLOW FILTERING;

USE airplanes;

SELECT airplane_id, capacity, airplane_type
FROM airplanes_by_type
WHERE airplane_type = 'Airbus A380';

SELECT flight_id, flight_no, airplane_type
FROM flights_by_airplane_type
WHERE airplane_type = 'Airbus A380' ALLOW FILTERING;
