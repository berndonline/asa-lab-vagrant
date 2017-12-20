#!/bin/bash

EXIT=0
vagrant up rtr-1 --color <<< 'rtr-1 boot' || EXIT=$?
vagrant up rtr-2 --color <<< 'rtr-2 boot' || EXIT=$?
vagrant up asa-1 --color <<< 'asa-1 boot' || EXIT=$?
echo $EXIT
exit $EXIT
