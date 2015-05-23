# Elixir Anonymous Functions
# Matthew Ahrens
# Ch 5

#an anonymous function is created using the fn keyword
#fn
  #paramtery-list -> body
  #parameter-list -> body
#end

#sum example
sum = fn (a,b) -> a + b end
#to invoke the function:
sum.(1,2) # >> 3

#anon function with no params
greet = fn -> IO.puts "Hello!" end
greet.()

#anon function with params but no () in decl
salutation = fn name -> IO.puts "goodbye, " <> name end
salutation.("Matt")

#functions and pattern matching
swap = fn {a,b} -> {b,a} end
swap.({1,2})

#exercises
list_concat = fn a,b -> a ++ b end
sum = fn (a,b,c) -> a + b + c end
pair_tuple_to_list = fn {a,b} -> [a,b] end

#one function, multiple bodies
handle_open = fn
  {:ok,file} -> "Read data: #{IO.read(file,:line)}"
  {_,error} -> "Error: #{:file.format_error(error)}"
end

#fizzbuzz exercises
fizzbuzz = fn
  0,0,_ -> "FizzBuzz"
  0,_,_ -> "Fizz"
  _,0,_ -> "Buzz"
  _,_,c -> c
end

exer_three = fn n -> fizzbuzz.(rem(n,3),rem(n,5),n) end

#functions can return functions
fun1 = fn -> fn -> "Hello" end end

#Functions remember their original environment (yay closure!)
greeter = fn name -> (fn -> "Hello, #{name}!" end) end
matt_greeter = greeter.("Matt")
matt_greeter.() # >> Hello, Matt!

#Parameterized functions
add_n = fn n -> (fn other -> n + other end) end
add_two = add_n.(2)
add_two.(3) # 5

#exercise: prefix
prefix = fn p -> (fn string -> "#{p} #{string}" end) end
dr = prefix.("Dr.")
dr.("Seuss")

#passing functions as arguments
times_2 = fn n -> n * 2 end
apply = fn (fun, value) -> fun.(value) end
apply.(times_2, 6) #12

add_one = &(&1 + 1) #fn n -> n + 1 end
#can also use & to shortcut named functions
l = &length/1

#exercises
#Enum.map[1,2,3,4],fn x -> x + 2 end
Enum.map [1,2,3,4],&(&1 + 2)
#Enum.map [1,2,3,4], fn x -> IO.inspect x end
i = &IO.inspect/1
Enum.map [1,2,3,4],i
