# test/jpypetest/test_pickle.py is failing on CI
# moving some basic test from there

import os
import pickle
import sys

import jpype
from jpype import java
from jpype.pickle import JPickler, JUnpickler

print(jpype.getDefaultJVMPath())
print(jpype.getClassPath())

jpype.startJVM()
filename = "test.pic"
try:
    s = java.lang.String("test")
    with open(filename, "wb") as fd:
        JPickler(fd).dump(s)
    with open(filename, "rb") as fd:
        s2 = JUnpickler(fd).load()
except pickle.UnpicklingError:
    dump(filename)
assert(s == s2)
