# /bin/bash

BIT=`getconf LONG_BIT`
RED='\033[0;31m'
NC='\033[0m' # No Color

function rand(){
    min=$1
    max=$(($2-$min+1))
    num=$(date +%s%N)
    echo $(($num%$max+$min))
}

installFile() {
    
    CAMERA_I2C_FILE_NAME="camera_i2c"
    CAMERA_I2C_FILE_DOWNLOAD_LINK="https://raw.githubusercontent.com/ArduCAM/MIPI_Camera/master/RPI/utils/camera_i2c"
    RPI3_GPIOVIRTBUF_FILE_NAME="rpi3-gpiovirtbuf"

    if [ ! -s $CAMERA_I2C_FILE_NAME ]; then
        wget -O $CAMERA_I2C_FILE_NAME $CAMERA_I2C_FILE_DOWNLOAD_LINK
        chmod +x $CAMERA_I2C_FILE_NAME
    fi
    if [ $? -ne 0 ]; then
        echo -e "${RED}Download failed.${NC}"
        echo "Please check your network and try again."
        exit -1
    fi

    if [ "$BIT" = 32 ]; then
        RPI3_GPIOVIRTBUF_FILE_DOWNLOAD_LINK="https://github.com/ArduCAM/MIPI_Camera/raw/master/RPI/utils/rpi3-gpiovirtbuf/32/rpi3-gpiovirtbuf"
    elif [ "$BIT" = 64 ]; then
        RPI3_GPIOVIRTBUF_FILE_DOWNLOAD_LINK="https://github.com/ArduCAM/MIPI_Camera/raw/master/RPI/utils/rpi3-gpiovirtbuf/64/rpi3-gpiovirtbuf"
    fi

    if [ ! -s $RPI3_GPIOVIRTBUF_FILE_NAME ]; then
        wget -O $RPI3_GPIOVIRTBUF_FILE_NAME $RPI3_GPIOVIRTBUF_FILE_DOWNLOAD_LINK
    fi

    if [ $? -ne 0 ]; then
        echo -e "${RED}Download failed.${NC}"
        echo "Please check your network and try again."
        exit -1
    else
        chmod +x $RPI3_GPIOVIRTBUF_FILE_NAME
        sudo ./camera_i2c>/dev/null 2>&1
    fi
}

installFile

for((i=1;i<=1000;i++));  
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