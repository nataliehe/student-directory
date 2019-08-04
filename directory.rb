# let's put all students into an array
# students = [
#   {name: "Dr. Hannibal Lecter", cohort: :november},
#   {name: "Darth Vader", cohort: :november},
#   {name: "Nurse Ratched", cohort: :november},
#   {name: "Michael Corleone", cohort: :may},
#   {name: "Alex DeLarge", cohort: :june},
#   {name: "The Wicked Witch of the West", cohort: :july},
#   {name: "Terminator", cohort: :may},
#   {name: "Freddy Krueger", cohort: :june},
#   {name: "The Joker", cohort: :june},
#   {name: "Joffrey Baratheon", cohort: :july},
#   {name: "Norman Bates", cohort: :july}
# ]
@students = [] # an empty array accessible to all methods

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  # students = []
  # get the first name
  puts "Name:"
  name = STDIN.gets.chomp
  # puts "Cohort:"
  # cohort = gets.chomp.to_sym
  # cohort = :november if cohort.empty?
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    @students << {name: name, cohort: :november}
    puts "Now we have #{@students.count} students"
    # get another name from the user
    puts "Name:"
    name = STDIN.gets.chomp
    # puts "Cohort:"
    # cohort = gets.chomp
  end
  # return the array of students
  # students
end

def print_header
  puts "The students of Villains Academy"
  puts "_____________"
end

def print_students_list
  @students.each.with_index(1) do |student, index|
    puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"
  end

  # i = 0
  # until i == students.length do
  #   puts "#{i + 1}. #{students[i][:name]} (#{students[i][:cohort]} cohort)".center(50)
  #   i += 1
  # end

  # cohorts = students.map { |student| student[:cohort]}.uniq
  # cohorts.each do |cohort|
  #   puts cohort
  #   students.each_with_index do |student, index|
  #     puts "#{index + 1}. #{student[:name]}" if student[:cohort] == cohort
  #   end
  # end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end
#nothing happends until we call the methods
# students = input_students
# print_header
# print(students)
# print_footer(students)

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  students = []
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu
