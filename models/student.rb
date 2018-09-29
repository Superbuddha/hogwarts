require ('pry-byebug')
require_relative('../db/sql_runner.rb')

class Student
  attr_reader :id
  attr_accessor :first_name, :last_name, :house_id, :age

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @house_id = options['house_id'].to_i
    @age = options['age'].to_i
  end

  def save()
    sql ="INSERT INTO students(
    first_name,last_name, house_id, age
    ) VALUES($1,$2,$3,$4) RETURNING id"
    values = [@first_name, @last_name, @house_id, @age]
    result =SqlRunner.run(sql, values)
    @id = result.first['id']
  end

  def self.find(id)
    sql = "SELECT * FROM students WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).first
    students = Student.new(result)
    return students
  end

  def self.all()
    sql = "SELECT * FROM students"
    student_data = SqlRunner.run(sql)
    students = map_items(student_data)
    return students
  end

  def self.map_items(student_data)
    return student_data.map {|student| Student.new(student)}
  end
end
