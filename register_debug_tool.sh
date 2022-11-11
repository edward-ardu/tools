# /bin/bash

function rand(){
    min=$1
    max=$(($2-$min+1))
    num=$(date +%s%N)
    echo $(($num%$max+$min))
}


for((i=1;i<=100000;i++));  
do 

rnd=$(rand 1 99)

i2ctransfer -y 10 w3@0x1a 0x01 0x36 0x$rnd
i2c_0136=`i2ctransfer -y 10 w2@0x1a 0x01 0x36 r1`
# echo $i2c_1136
# echo 0x$rnd

if [ $rnd -lt 10 ]
then
    rnd="$rnd"
    rnd="0$rnd"

    # echo $rnd
fi

if [ 0x$rnd == $i2c_0136 ]
then
    echo Success
else
    echo $i2c_0136
    echo 0x$rnd
    echo "write error"
    exit 1
fi

rnd=$(rand 1 99)
i2ctransfer -y 10 w3@0x1a 0x01 0x37 0x$rnd
i2c_0137=`i2ctransfer -y 10 w2@0x1a 0x01 0x37 r1`
if [ $rnd -lt 10 ]
then
    rnd="$rnd"
    rnd="0$rnd"

    # echo $rnd
fi

if [ 0x$rnd == $i2c_0137 ]
then
    echo Success
else
    echo $i2c_0137
    echo 0x$rnd
    echo "write error"
    exit 1
fi

done