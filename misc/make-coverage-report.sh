#!/bin/sh
mkdir -p coverage-report
gcovr -f 'modules/gdscript/gdscript_(parser|compiler|tokenizer|function|functions)\.(cpp|h)' -r . --html --html-details -o coverage-report/index.html -j 16 -s
