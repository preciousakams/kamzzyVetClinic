/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL(10,5),
    PRIMARY KEY(id)
);
ALTER TABLE animals ADD COLUMN species VARCHAR(100);

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100),
    age INT,
    PRIMARY KEY(id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    PRIMARY KEY(id)
);
-- Remove column species
ALTER TABLE animals DROP COLUMN species;
-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id) ON DELETE CASCADE;
-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY(owner_id) REFERENCES owners(id) ON DELETE CASCADE;

CREATE TABLE vets (
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(100),
age INT,
date_of_graduation DATE,
PRIMARY KEY(id)
);

-- //// MANY TO MANY RELATIONSHIP
CREATE TABLE specializations (
 species_id INT,
 vet_id INT,
 FOREIGN KEY(species_id) REFERENCES species(id) ON DELETE CASCADE,
 FOREIGN KEY(vet_id) REFERENCES vets(id) ON DELETE CASCADE
);
CREATE TABLE visits (
 animal_id INT,
 vet_id INT,
 date_of_visit DATE,
 CONSTRAINT fk_animal FOREIGN KEY(animal_id) REFERENCES animals(id) ON DELETE CASCADE,
 CONSTRAINT fk_vet FOREIGN KEY(vet_id) REFERENCES vets(id) ON DELETE CASCADE
);
-- ///// week 2/////
ALTER TABLE owners ADD COLUMN email VARCHAR(120);