"""
String Literals
Matthew Ahrens
Chapter 11
"""
#single quoted vs double quoted
#Both can hold UTF-8 encoded characters
#Both can have escape sequences
# \a, \e. \r, \v, \b,\ f, \s, \d, \n, \t, \xhhh (hex digit)

#string interpolation
name = "Matt"
str1 = "Hello, #{name}!"
str2 = 'Goodbye, #{name}!'

#Support heredocs: any string that spans several lines
IO.puts "start"
IO.write "
  my
  string
"
IO.puts "end"

#vs
IO.puts "start"
IO.write """
  my
  string
  """
IO.puts "end"

#used to add documentation to functions and modules

#sigils: start with a tilde, followed by an upper or lowercase letter,
  #some content, and some options
#delimiters can be: {},[],(),||,//,"",''
"""
Characters:
~C character list with no escaping nor interpolation
~c character list with escaping and interpolation, same as ''
~R regular expression with no escaping or interpolation
~r A regular expression, escaped and interpolated
~S A string with no escaping or interpolation
~s A string with escaping, interpolation, same as ""
~W A list of whitelist delimited words, no esc, int
~w A list of whitelist delimited words with escaping and interpolation
w specifiers take a (atoms), c (characters), or s (strings) as option:
"""
~w[the c#{'a'}t sat on the mat]a

#single quoted - character lists
cl = 'wombat'
is_list cl
length cl # 6
Enum.reverse cl
#pattern matching
'pole'++'vault'
'pole'--'vault' #poe
List.zip ['abc','123']
[head | tail] = 'cat'
#example
defmodule Parse do
  def number([ ?- | tail]), do: _number_digits(tail,0) * -1
  def number([ ?+ | tail]), do: _number_digits(tail,0)
  def number(cl),           do: _number_digits(cl,0)
  defp _number_digits([], value), do: value
  defp _number_digits([digit|tail], value)
  when digit in '0123456789' do
    _number_digits(tail,value*10 + digit - ?0)
  end
  defp _number_digits([non_digit | _], _) do
    raise "Invalid digit '#{[non_digit]}'"
  end
  #Exercise
  def ascii?([]), do: true
  def ascii?([head|tail]) do
    if (head >= ?\s) and (head <= ?~) do
      ascii?(tail)
    else
      false
    end
  end
  #Exercise
  def anagram?(word1,word2), do: (word1 -- word2) == [] and (word2 -- word1) == []
  #def calculate(exp), do: _calculate(exp)

end
#binaries: sequence of bits
#<<term, ...>>
#example
b=<<1,2,3,4,5>>
byte_size b
bit_size b
b2 = <<1::size(2), 1::size(3)>>
byte_size b2
bit_size b2
i = <<1>>
f = <<2.5 :: float >>
mix = <<i :: binary, f :: binary >>
#double quoted strings as binaries
dqs = "ẟx/ẟy"
String.length dqs
byte_size dqs
bit_size dqs
String.at(dqs,0)
String.codepoints(dqs)
String.split(dqs,"/")
String.capitalize "ǽther"
String.downcase("HELLO")
String.duplicate("lol",10)
String.ends_with? "This string ends with cat", ["cat", "dog", "bird"]
String.first("ølol")
String.graphemes("®†¥")
String.last("lol√")
String.length("four")
String.ljust "Hello", 15

name = "Mike"
String.ljust name, String.length(name)+1, ?©
String.lstrip "    Hello"
String.next_codepoint("Hello, world!")
#Example module
defmodule MyString do
  #iterator example for next_codepoint
  def each(str,func),do: _each(String.next_codepoint(str),func)
  defp _each(nil,_),do: []
  defp _each({codepoint,rest},func)do
    func.(codepoint)
    _each(String.next_codepoint(rest),func)
  end
  #exercise 5
  def center list do
    ord_list = Enum.sort list, &(String.length(&1) >= String.length(&2))
    s_ord_list = Enum.reverse ord_list
    [ohead|otail] = ord_list
    max_len = String.length ohead
    Enum.each(s_ord_list, fn x ->
      str = x
        |> String.rjust (div(max_len - String.length(x),2))
        |> String.ljust (div(max_len - String.length(x),2))
      IO.puts str
      end)
  end
  #Exercise 6
  def cap_sentence string do
    string
      |> String.downcase
      |> String.split ".", global: true
      |> Enum.map_reduce &(&1 ++ &2), &(String.capitalize/1)
      # "OH NO. the dog got out. again." -> "Oh no. The dog got out. Again."
  end

end
MyString.each "📱🍡🌊", fn c -> IO.puts c end
String.next_grapheme("Hello")
String.printable?("David")
String.printable?("\x{0000} a null")
String.replace("Hello", "ello", "lololol")
String.replace("Goodbye, lullabye","bye","day", global: true) #insert_replaced: 0 | [0,2]
String.reverse("Danny Boy")
String.rjust("String", 20,?†)
String.rstrip("Hello")
String.rstrip("Hello...",?.)
String.slice("Hello",3,2)
String.split("Hello, World",",",global: true)
String.starts_with?("Hello","Hell")
String.strip("    Oh, no!   ")
String.strip("...nothing...",?.)
String.upcase("coolio")
String.valid_character?("∑")
String.valid_character?("dog")

#Binaries and pattern matching
defmodule Utf8 do
  def each(str,func) when is_binary(str), do: _each(str,func)
  defp _each(<<head :: utf8, tail :: binary >>, func) do
    func.(head)
    _each(tail,func)
  end
  defp _each(<<>>, _func), do: []
end
