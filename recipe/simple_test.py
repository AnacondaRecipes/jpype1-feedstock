# A snippet code from customer

import jpype

jpype.startJVM()
String = jpype.JClass("java.lang.String")
java_string = String("hello, jpype!")
print(java_string.toUpperCase())
