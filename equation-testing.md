# Automatically checking LaTeX equations, preferably as printed in the document

It would be nice to perform "spot checks" on equations printed in a document. A *parallel* implementation in a separate (say Python) file is one way, but the equations are not necessarily the same in this case.

Idea: Require good practices that help with error detection, like grouping terms into dimensionless numbers to help spot dimensionality errors.

## Also see

- <http://lurchmath.org/> and <https://monks.scranton.edu/lurch/>
- <https://xenaproject.wordpress.com/2021/06/05/half-a-year-of-the-liquid-tensor-experiment-amazing-developments/>
- <https://academia.stackexchange.com/questions/171673/automated-proof-checking-at-journals>

## How can the same equation be tested?

- <https://tex.stackexchange.com/q/52392/9945>
- <https://docs.sympy.org/latest/modules/parsing.html>
- <https://github.com/augustt198/latex2sympy>
- Content Oriented LaTeX: <https://ctan.org/pkg/cool>
   - > One advantage of keeping mathematical meaning is that conversion of LaTeX documents to other executable formats (such as Content MathML or Mathematica code) is greatly simplified.
   - <http://xahlee.info/cmaci/notation/TeX_pestilence.html>

## Implementation with "parallel" (nominally identical) equations

- <https://docs.python.org/3/library/configparser.html>
- Make LuaTeX output an error if an equation is not marked as checked. The checking is done by satisfying tests in a Python script, e.g., dimensional homogeneity or having the expected dimension, the equation having a reasonable value, the equation being within certain bounds, etc. LuaTeX could check an external file to see if an equation with a particular label has passed checks.

## Annotating manual checks

- Replace the `equation`, `align`, `equation*`, and `align*` environments with environments with an optional `checked` argument.
   - Replace the existing environments in bmtmacros.sty (for example, `uncheckedequation`) with something that uses the normal environment names.
   - etoolbox package to patch these environments with `\AtBeginEnvironment`?
   - environ package per <https://tex.stackexchange.com/a/596396/9945>

## TODO

- TODO: How to require labels for all equations? Ask on tex.stackexchange.com. One approach: Count the number of equation and align environments with a regular expression. The number of labels must be greater than or equal to the number of equation and align environments. Align environments are likely to have more than one equation, but do not necessarily do so.
- Make eqcheck highlight errors in color like grep matches.
