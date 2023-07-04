import time


def left_to_right(n):
    start_time = time.time()

    result = 0
    for i in range(1, n + 1):
        result += 1 / i ** 2

    duration = time.time() - start_time
    output = f"left to right calculation result for n = {n}:\n" \
             f"result: {result}\n" \
             f"duration: {duration} seconds."

    return output


def right_to_left(n):
    start_time = time.time()

    result = 0
    for i in range(n, 0, -1):
        result += 1 / i ** 2

    duration = time.time() - start_time
    output = f"right to left calculation result for n = {n}:\n" \
             f"result: {result}\n" \
             f"duration: {duration} seconds."

    return output
