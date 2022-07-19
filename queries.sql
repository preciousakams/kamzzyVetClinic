/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';
-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '20160131' AND '20191231';
-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered ='true' AND escape_attempts <3;
-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name= 'Agumon' OR name= 'Pikachu';
-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5;
-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = 'true';
-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon';
-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg = 10.4 OR 17.3 OR weight_kg BETWEEN 10.4 AND 17.3;
-- nside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;
-- Inside a transaction:
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-- Commit the transaction.
-- Verify that change was made and persists after commit.
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE name NOT LIKE '%mon';
 COMMIT;
SELECT * FROM animals;
-- Inside a transaction delete all records in the animals table, then roll back the transaction.
-- After the rollback verify if all records in the animals table still exists.
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;
-- Inside a transaction:
-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
BEGIN;
SAVEPOINT save1;
DELETE FROM animals WHERE date_of_birth > '20220101';
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO save1;
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction
BEGIN;
SELECT * FROM animals;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
-- Write queries to answer the following questions:

-- How many animals are there?
SELECT COUNT(*) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT neutered,MAX(escape_attempts) FROM animals GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT species,MIN(weight_kg),MAX(weight_kg) FROM animals GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
 SELECT species,AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '19900101' AND '20001231' GROUP BY species;
-- // Milestone3
-- What animals belong to Melody Pond?
SELECT full_name, name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Melody Pond';
-- List of all animals that are pokemon (their type is Pokemon).
SELECT species.name, animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name, name FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id;
-- How many animals are there per species?
SELECT species.name, COUNT(species.name) FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;
-- List all Digimon owned by Jennifer Orwell.
 SELECT full_name,species.name, animals.name FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.owner_id = owners.id WHERE species.name = 'Digimon' AND full_name = 'Jennifer Orwell';
-- List all animals owned by Dean Winchester that haven't tried to escape.
 SELECT full_name,animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Dean Winchester' AND escape_attempts = 0;
-- Who owns the most animals?
 SELECT full_name,COUNT(animals.owner_id) FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY full_name, animals.owner_id ORDER BY COUNT(animals.owner_id) DESC LIMIT 1;

-- Milestone4

-- Who was the last animal seen by William Tatcher?
SELECT vets.name, animals.name, date_of_visit FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Vet William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;
-- How many different animals did Stephanie Mendez see?
SELECT vets.name,COUNT(animals.name) FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Vet Stephanie Mendez' GROUP BY vets.name;
-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name,species.name FROM specializations FULL OUTER JOIN vets ON specializations.vet_id = vets.id FULL OUTER JOIN species ON specializations.species_id = species.id;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT vets.name, animals.name, date_of_visit FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Vet Stephanie Mendez' AND date_of_visit BETWEEN '20200401' AND '20200830';
-- What animal has the most visits to vets?
SELECT animals.name, COUNT(date_of_visit) FROM visits JOIN animals ON visits.animal_id = animals.id GROUP BY animals.name ORDER BY COUNT(date_of_visit) DESC LIMIT 1;
-- Who was Maisy Smith's first visit?
SELECT vets.name, animals.name, date_of_visit FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Vet Maisy Smith' ORDER BY date_of_visit ASC LIMIT 1;
-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT vets.name,vets.age, date_of_graduation,animals.name,date_of_birth,escape_attempts,neutered,weight_kg,date_of_visit FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id  ORDER BY date_of_visit DESC LIMIT 1;
-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id JOIN specializations ON specializations.vet_id = vets.id JOIN species ON specializations.species_id = species.id WHERE animals.species_id <> specializations.species_id;
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name,COUNT(species.name) FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vet_id = vets.id JOIN species ON animals.species_id = species.id WHERE vets.name = 'Vet Maisy Smith' GROUP BY species.name ORDER BY COUNT(species.name)DESC LIMIT 1;

-- //////// WEEK 2 /////////////
-- SELECT COUNT(*) FROM visits where animal_id = 4;
-- SELECT * FROM visits where vet_id = 2;
-- SELECT * FROM owners where email = 'owner_18327@mail.com';
-- Use EXPLAIN ANALYZE on the previous queries to check what is happening. Take screenshots of them - they will be necessary later.

-- Find a way to decrease the execution time of the first query. Look for hints in the previous lessons.
CREATE INDEX animal_id_asc ON visits(animal_id ASC); -- execution time decreased
-- Find a way to improve execution time of the other two queries.
CREATE INDEX vet_id_asc ON visits(vet_id ASC);
CREATE INDEX owner_full_name_asc ON owners(full_name ASC);












