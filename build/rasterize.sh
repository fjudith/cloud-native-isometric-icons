#!/bin/bash

SIZES=(128 256)

docker build -t svgconvertor:latest -f build/Dockerfile .

total=$(find svg/ -name *.svg | wc -l)
counter=1

for size in "${SIZES[@]}"; do 
    for svg in $(find svg/ -name *.svg | cut -b 5-); do
        dir=$(dirname -- ${svg})
        # echo "Create directory \"png/${dir}\""
        mkdir -p png/${dir}
        output=png/${svg%%.*}-${size}.png
        echo "[$counter/$total] Generating $output"
        docker run -v $(pwd)/svg:/convertor svgconvertor:latest  $svg -w $size > $output
        counter=$[$counter +1]
    done
done