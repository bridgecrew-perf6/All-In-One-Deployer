#!/bin/bash

if [ -f .env ]
    then
        # source .env
        eval $(egrep "^[^#;]" .env | xargs -d'\n' -n1 | sed 's/^/export /')
        # while read line; do
        #     [[ "$line" =~ ^#.*$ ]] && continue
        #     export $line
        #     # export $(grep -v '^#' ${line} | xargs -d '\n')
        #     # export $(grep -v '^#' $line | xargs -d '\n')
        # done < .env
else
    echo "ERROR: .env not found"
fi