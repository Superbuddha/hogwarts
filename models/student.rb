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
end
