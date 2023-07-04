from calculator import *
from math import *

limit = pi ** 2 / 6
print("calculating the result of series 1 / n ** 2 with two methods.\n"
      f"the limit of series is (pi ^ 2) / 6 or: {limit}")
n = int(input("enter n: "))

print(left_to_right(n) + "\n" + right_to_left(n))
