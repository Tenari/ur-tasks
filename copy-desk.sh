# Usage:
# ./copy-desk.sh <ship_name>

mkdir -p "../$1/tasks" && cp -R -f desk/* ../$1/tasks && echo "~$1" > ../$1/tasks/desk.ship


# Pulling relevant files from base
cp -R -f ../$1/base/mar/noun.hoon ../$1/tasks/mar/noun.hoon
cp -R -f ../$1/base/mar/kelvin.hoon ../$1/tasks/mar/kelvin.hoon
cp -R -f ../$1/base/mar/mime.hoon ../$1/tasks/mar/mime.hoon

 # Pulling relevant files from garden
cp -R -f ../$1/garden/lib/docket.hoon ../$1/tasks/lib/docket.hoon
cp -R -f ../$1/garden/sur/docket.hoon ../$1/tasks/sur/docket.hoon
cp -R -f ../$1/garden/sur/treaty.hoon ../$1/tasks/sur/treaty.hoon

