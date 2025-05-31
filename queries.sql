-- Active: 1748685032977@@127.0.0.1@5432@postgres@conservation_db


 SELECT * FROM rangers;

SELECT setval('rangers_ranger_id_seq', (SELECT MAX(ranger_id) FROM rangers));

INSERT INTO rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');


SELECT COUNT(DISTINCT species_id) AS unique_species_count FROM sightings;


SELECT * FROM sightings WHERE location LIKE '%Pass%';

SELECT r.name, COUNT(s.sighting_id) AS total_sightings
FROM rangers r
LEFT JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY r.name;

SELECT common_name FROM species
WHERE species_id NOT IN (SELECT DISTINCT species_id FROM sightings);

SELECT sp.common_name, s.sighting_time, r.name
FROM sightings s
JOIN species sp ON s.species_id = sp.species_id
JOIN rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC
LIMIT 2;

UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

SELECT sighting_id,
  CASE
    WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM sighting_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings;

DELETE FROM rangers
WHERE ranger_id NOT IN (SELECT DISTINCT ranger_id FROM sightings);
