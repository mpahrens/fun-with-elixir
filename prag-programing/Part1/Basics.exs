# Elixir Basics
# Matthew Ahrens
# Ch 4

#integers

basics_decimal_int1 = 1

basics_hex1 = 0xcafe
basics_oct1 = 0o765
basics_bin1 = 0b1010

#decimal numbers can contain _s for readability, cool!

one_million = 1_000_000

#floating point number, must have a number preceding the .

basics_float1 = 1.6
basics_float2 = 0.4 # .4 is not good enough
basics_float3 = 0.31131313e10
# maximum exponent of 10^308

# atoms
#constants whose name is also their value
:fred #simple constants
:is_binary? #functions that return bools
:var@2 #vars
:<> #ops
:"func/3" #function def containing special chars
:"hello world" #constants containing spaces

#ranges

1..5 # 1 2 3 4 5

#regex

#written as: ~r{regex} or ~r{regex}ops

basics_regex1 = Regex.run ~r{[aeiou]}, "caterpillar" # ["a"]
basics_regex2 = Regex.scan ~r{[aeiou]}, "caterpillar" # [["a"],["e"],["i"],["a"]]
basics_regex3 = Regex.split ~r{[aeiou]}, "caterpillar" # ["c","t", "rp", "ll", "r"]
basics_regex4 = Regex.replace ~r{[aeiou]}, "caterpillar", "*" # "c*t*rp*ll*r"

#PID

self

### collections

#tuples
{1,2}
{:ok,42,"hello"} #mixed types

#common practice, returning a tuple with {:ok, <value>} to note that unsafe functions worked as intended
{status,file} = File.open("Basics.exs") #{:ok,#PID<#>}

#list

[1,2,3] ++ [4,5,6] # [1,2,3,4,5,6]

[1,2,3] -- [1,2] # [3]

1 in [1,2,3,4] # true
"hello" in [1,2,3,4] # false

# keyword lists - key,value pairs
[name: "Matt", city: "Medford", likes: "vidjagams"] # syntactic sugar for [{:name, "Matt"}, {:city, "Medford"}, {:likes, "vidjagams"}]

#Maps
my_map = %{:name => "Matthew", :city => "Medford"} # also could use: %{name: "Matthew", city: "Medford"} to mean the same thing as a shortcut
my_other_map = %{:species  => :dog, :name  =>  "Roofus"}

my_map[:name] # "Matthew" -- pulling something from the list that doesn't exist can result in nil

IO.puts my_map[:name]

#can use pretty much anything as a key
%{
  {:error,:enoent} => :fatal,{:error, :busy}  => :retry}

 #can use . notation
 my_map.name # if key does not exist, gets KeyError instead of nil

 #binaries

 bin = << 1,2 >>
 byte_size bin # 2

 bin2 = <<2 :: size(2), 5 :: size(4), 1 :: size 2 >> # byte_size bin2 is 1 (8 bits) and has a value of <<213>>

#conventions

"""
Starting with uppercase:

#Modules

#records

#protocols

#behaviors

#identifiers may only use ASCII, but elixir supports UTF8

#boolean: true, false, nil (nfalse in bool contets), true is the same as :true, false :false, etc, nil :nil, values other than false and nil are considered true

#ops
#strictly equal / inequal
1 === 1 #true
1 === 1.0 #false
1 !== 1.0 #true

#value equal / inequal
1 == 1.0 # true
1 != 1.0 # false

#comparison
a > b
a >= b
a < b
a <= b

#bool ops: expect boolean values true or false as their first arg
a or b
a and b
not a
#relaxed bool ops
a && b
a || b
!a

#arith
1+1
2-1
1 * 4
9 / 3 # 3.0, always returns a float
9 div 3 # 3, integer division if operands are ints
9 rem 2 # 1, remainder

#join operators
binary1 <> binary2 #concats binaries, like strings
list1 ++ list2
list1 -- list2

#in operator
a in enum #tests if a is included in enum, bool value
"""
