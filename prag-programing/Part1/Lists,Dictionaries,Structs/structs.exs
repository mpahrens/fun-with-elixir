"""
Structs and sets
Matthew Ahrens
Chapter 8
"""
defmodule Subscriber do
  defstruct name: "", paid: false, over_18: true
end

#Make one
s1 = %Subscriber{}
s2 = %Subscriber{name: "Matt"}
s3 = %Subscriber{name: "Kelly", over_18: true, paid: true}
#access
s1.name
#use | for update
#add square bracket notation

defmodule User do
  @derive Access
  defstruct name: "", online: false
end
u1 = %User{}
u1[:name]

#nested structures
defmodule FanBase do
  defstruct fan: %{}, fav: ""
end

f = %FanBase{fan: %User{name: "Matt"}, fav: "Digital: A Love Story"}
f.fan.online
#update nested without nested pipes
put_in(f.fan.online, true)
#update_in, get_in, get_and_update_in

#Hash Sets
set1 = Enum.into 1..5, HashSet.new
#Set.member?, Set.union, Set.difference, Set.intersection
