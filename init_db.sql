CREATE TABLE cities (
    id SERIAL PRIMARY KEY,
    state VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL,
    city_name VARCHAR(255) NOT NULL
);

INSERT INTO cities (state, country, city_name) VALUES
('California', 'USA', 'Los Angeles'),
('New York', 'USA', 'New York City'),
('Ontario', 'Canada', 'Toronto'),
('Quebec', 'Canada', 'Montreal'),
('England', 'UK', 'London'),
('Scotland', 'UK', 'Edinburgh'),
('New South Wales', 'Australia', 'Sydney'),
('Victoria', 'Australia', 'Melbourne'),
('Bavaria', 'Germany', 'Munich'),
('Berlin', 'Germany', 'Berlin');