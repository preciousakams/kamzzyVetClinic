CREATE TABLE patients (
id INT,
name VARCHAR,
date_of_birth DATE,
PRIMARY key(id)
);

CREATE TABLE medical_histories(
id INT,
admitted_at TIMESTAMP,
patient_id INT,
status VARCHAR,
PRIMARY KEY(id),
FOREIGN KEY(patient_id) REFERENCES patients(id) ON DELETE CASCADE
);

CREATE TABLE invoices(
  id INT,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT,
  PRIMARY KEY(id),
  FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id) ON DELETE CASCADE
);

CREATE TABLE invoice_items(
  id INT,
  unit_price DECIMAL,
  quantity INT,
  total_price,
  invoice_id INT,
  treatment_id INT,
  PRIMARY KEY(id),
  FOREIGN KEY(invoice_id) REFERENCES invoices(id) ON DELETE CASCADE,
  FOREIGN KEY(treatment_id) REFERENCES treatments(id) ON DELETE CASCADE
); 

CREATE TABLE treatments (
  id INT PRIMARY KEY,
  type VARCHAR,
  name VARCHAR,
  FOREIGN KEY(id) REFERENCES medical_histories(id) ON UPDATE CASCADE
);

CREATE INDEX patients_name_asc ON patients(name ASC);
CREATE INDEX treatment_name_asc ON treatments(name ASC);
CREATE INDEX invoice_generated_at_asc ON invoices(generated_at ASC);
CREATE INDEX admitted_at_asc ON medical_histories(admitted_at ASC);