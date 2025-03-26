# There's a bug (?) in jpype code in searching for jvm.
# It's using os.walk to find libjvm.so, and os.walk is returning paths in arbitrary order
# which can result in picking wrong one, as openjdk has two of them (and this is expected).
# If the wrong jvm is picked, it's changing java.home property, which results in
# jvm being unable to locate java.security file.
# 0002-fix-find_libjvm.patch addresses that by setting conda_preferred_jvm in priority
# to whatever os.walk finds.

# This is testing that java.security can be loaded properly.

import os
import pickle
import sys

import jpype
from jpype import java
from jpype.pickle import JPickler, JUnpickler

print(jpype.getDefaultJVMPath())
print(jpype.getClassPath())
jpype.startJVM()
print(jpype.java.lang.System.getProperty("java.home"))

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
