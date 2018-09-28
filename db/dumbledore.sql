DROP TABLE students;

CREATE TABLE students(
  id SERIAL8 primary key,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  house_id INT8 REFERENCES houses(id),
  age INT4
);
