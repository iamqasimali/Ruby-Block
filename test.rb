
# Practical Block Examples
#1. timing with yield, "run around"
#2. lazy code, pass your own logic, customize logic
# 3. callback, on_complete / on_failure

# def time
# start = Time.now
# yield
# Time.now - start
# end
# time { "a" * 10000000 } # => 0.003922107


### Block is sleeping 
{a: 1 }.fetch(:a) { 123} # => 1

### Block is calling its own logic
{a: 1 }.fetch(:b) { 123} # => 123


### Callback example
def download(url, &on_complete)
  puts "Downloading from #{url}..."
  sleep(2) # Simulate a download time
  puts "Download complete."
  on_complete.call if on_complete
end


## Splat operator
def greet(*names)
 names.each { |name| puts "Hello, #{name}!" }
end


greet("Alice", "Bob", "Charlie")
# Output:
# Hello, Alice!
# Hello, Bob!
# Hello, Charlie!


def configure(**options)
  options.each { |key, value| puts "#{key}: #{value}" }
end

configure(host: "localhost", port: 8080, debug: true)
# Output:
# host: localhost
# port: 8080
# debug: true




## Block  
students = ['Greyson', 'Logan', 'Steve', 'Tony']


students = ['Greyson', 'Logan', 'Steve', 'Tony']
students.each { |student| puts student }


students.each_with_index do |student, i|
puts student
puts i
end



### Array Expansion (Destructuring).
### When used before an array in a method call or assignment, the single splat operator expands
### the array's elements into individual arguments or values.

def sum(a, b, c)
    a + b + c
end

numbers = [1, 2, 3]
puts sum(*numbers) # Expands [1, 2, 3] to 1, 2, 3
# Output: 6



first, *rest = [1, 2, 3, 4, 5]
puts first # Output: 1
puts rest.inspect # Output: [2, 3, 4, 5]




#### block as  PROCS -> CALLING BLOCK WITH .CALL METHOD
### here block is passed as a Proc object using &blk parameter
### and its called explicitly with .call method

def each (array, &blk)
    i = 0
    while i < array.count
        el = array[i]
        blk.call(el)
        i += 1
    end
end

each (students) do |student |
puts student
end


def each (array)
    if !block_given?
        puts "No block given"
    return
    end
i = 0
    while i < array.count
        el = array[i]
        yield el
        i += 1
    end
end

each (students)
# do |student|
# puts student
# end


# Output:
# Greyson
# Logan
# Steve 
# Tony


### Procs