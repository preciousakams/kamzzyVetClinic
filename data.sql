/* Populate database with sample data. */

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Agumon','20200203',0,'true',10.23);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Gabumon','20181115',2,'true',8);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Pikachu','20210107',1,'false',15.04);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Devimon','20170512',5,'true',11);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Charmander','20200208',0,'false',-11);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Plantmon','20211115',2,'true',-5.7);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Squirtle','19930402',3,'false',-12.13);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Angemon','20050612',1'true',-45);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Boarmon','20050607',7,'true',20.4);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Blossom','19981013',3,'true',17);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Ditto','20220514',4,'true',22);

INSERT INTO owners (full_name,age) VALUES('Sam Smith',34),('Jennifer Orwell',19),
('Bob',45),('Melody Pond',77),('Dean Winchester',14),('Jodie Whittaker',38);
INSERT INTO species (name) VALUES('Pokemon'),('Digimon');
-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE name NOT LIKE '%mon';
-- Modify your inserted animals to include owner information (owner_id):

-- Sam Smith owns Agumon.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name = 'Gabumon' OR name = 'Pikachu';
-- Bob owns Devimon and Plantmon.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name = 'Devimon' OR name = 'Plantmon';
-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name = 'Angemon' OR name = 'Boarmon';

-- // Milestone4
INSERT INTO vets(name,age,date_of_graduation) VALUES('Vet William Tatcher',45,'20000423'),
('Vet Maisy Smith',26,'20190117'),('Vet Stephanie Mendez',64,'19810504'),('Vet Jack Harkness',38,'20080608');

-- Insert the following data for specialties
-- Vet William Tatcher is specialized in Pokemon.
INSERT INTO specializations(species_id, vet_id) VALUES ((SELECT id FROM vets WHERE name = 'Vet William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon'));
-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
INSERT INTO specializations(species_id, vet_id) VALUES ((SELECT id FROM species WHERE name = 'Digimon'),(SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez')),((SELECT id FROM species WHERE name = 'Pokemon'),(SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez'));
-- Vet Jack Harkness is specialized in Digimon.
INSERT INTO specializations(species_id, vet_id) VALUES ((SELECT id FROM species WHERE name = 'Digimon'),(SELECT id FROM vets WHERE name = 'Vet Jack Harkness'));

-- Insert the following data for visits:
-- Agumon visited William Tatcher on May 24th, 2020.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Agumon'),(SELECT id FROM vets WHERE name = 'Vet William Tatcher'),('20200524'));
-- Agumon visited Stephanie Mendez on Jul 22th, 2020.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Agumon'),(SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez'),('20200722'));
-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Gabumon'),(SELECT id FROM vets WHERE name = 'Vet Jack Harkness'),('20210202'));
-- Pikachu visited Maisy Smith on Jan 5th, 2020.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Pikachu'),(SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),('20200105'));
-- Pikachu visited Maisy Smith on Mar 8th, 2020.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Pikachu'),(SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),('20200308'));
-- Pikachu visited Maisy Smith on May 14th, 2020.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Pikachu'),(SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),('20200508'));
-- Devimon visited Stephanie Mendez on May 4th, 2021.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Devimon'),(SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez'),('20210504'));
-- Charmander visited Jack Harkness on Feb 24th, 2021.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Charmander'),(SELECT id FROM vets WHERE name = 'Vet Jack Harkness'),('20210224'));
-- Plantmon visited Maisy Smith on Dec 21st, 2019.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Plantmon'),(SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),('20191221'));
-- Plantmon visited William Tatcher on Aug 10th, 2020.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Plantmon'),(SELECT id FROM vets WHERE name = 'Vet William Tatcher'),('20200810'));
-- Plantmon visited Maisy Smith on Apr 7th, 2021.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Plantmon'),(SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),('20210407'));
-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Squirtle'),(SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez'),('20190929'));
-- Angemon visited Jack Harkness on Oct 3rd, 2020.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Angemon'),(SELECT id FROM vets WHERE name = 'Vet Jack Harkness'),('20201003'));
-- Angemon visited Jack Harkness on Nov 4th, 2020.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Angemon'),(SELECT id FROM vets WHERE name = 'Vet Jack Harkness'),('20201104'));
-- Boarmon visited Maisy Smith on Jan 24th, 2019.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Boarmon'),(SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),('20190124'));
-- Boarmon visited Maisy Smith on May 15th, 2019.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Boarmon'),(SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),('20190515'));
-- Boarmon visited Maisy Smith on Feb 27th, 2020
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Boarmon'),(SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),('20190227'));.
-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Boarmon'),(SELECT id FROM vets WHERE name = 'Vet Maisy Smith'),('20200803'));
-- Blossom visited Stephanie Mendez on May 24th, 2020.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Blossom'),(SELECT id FROM vets WHERE name = 'Vet Stephanie Mendez'),('20200524'));
-- Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO visits(animal_id,vet_id,date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Blossom'),(SELECT id FROM vets WHERE name = 'Vet William Tatcher'),('20210111'));