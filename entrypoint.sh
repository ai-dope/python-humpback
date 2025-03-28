#! /usr/bin/env bash

python -m venv $VIRTUAL_ENV
. $VIRTUAL_ENV/bin/activate

echo "[$(python --version)] running @ [$(which python)]"

pip install -q -r requirements.txt 2>&1
clear

$@