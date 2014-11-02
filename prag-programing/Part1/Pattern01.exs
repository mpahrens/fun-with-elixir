#Pattern Matching
#Matthew Ahrens
#Ch 2
a0 = 1 #matching, not assignment

# --
a1 = 1

1 = a1 #valid

2 = a1 # 2 does not = 1, so match cannot be made

# --

list2 = [1,2,3]

[a2,b2,c2] = list

a2

b2

c2

# --
list3 = [1,2,[3,4,5]]
[a3,b3,c3] = list

a3

b3

c3

# --

#valid pattern matching
list4 = [1,2,3]
[a4,2,b4] = list

#not valid
[a5,1,b5] = list #RHS does not match LHS because 2 != 1

# -- PatternMatching - 1
[list6] = [[1,2,3]] #list6: [1,2,3]

# --

# _ is don't care pattern matching
[1,_,_] = [1,2,3]

# -- exercise PattenMatching - 2
[a7,b7,a7] = [1,2,1]

# -- exercise PatternMatching - 3
a8 = 2 #given  a8 contains 2
a8 = 1 # "reassigns a8" to 1
^a8 = 2 # matches
