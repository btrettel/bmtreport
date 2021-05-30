# Automatically checking LaTeX equations, preferably as printed in the document

It would be nice to perform "spot checks" on equations printed in a document. A *parallel* implementation in a separate (say Python) file is one way, but the equations are not necessarily the same in this case.

Idea: Require good practices that help with error detection, like grouping terms into dimensionless numbers to help spot dimensionality errors.

Also see: <http://lurchmath.org/> and <https://monks.scranton.edu/lurch/>

## How can the same equation be tested?

- <https://tex.stackexchange.com/q/52392/9945>
- <https://docs.sympy.org/latest/modules/parsing.html>
- <https://github.com/augustt198/latex2sympy>

## Implementation with different (nominally identical) equations

- <https://docs.python.org/3/library/configparser.html>
- Make LuaTeX output an error if an equation is not marked as checked. The checking is done by satisfying tests in a Python script, e.g., dimensional homogeneity or having the expected dimension, the equation having a reasonable value, the equation being within certain bounds, etc. LuaTeX could check an external file to see if an equation with a particular label has passed checks.
