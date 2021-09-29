#!/bin/bash
if [ "$1" == "" ]; then
    echo "You need a parameter which will be the alias of the scratch org"
    exit 1
fi

sfdx force:org:create -f config/project-scratch-def.json -s -a $1

sfdx force:source:push
sfdx force:user:permset:assign -n EcoVadis_Administrator

sfdx force:user:create -a $1user
