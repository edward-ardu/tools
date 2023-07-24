# tools
Some small programs to help detect errors
Cancel changes
The above tools are only available for Raspberry Pi or jetson.  
  
## Detect_HAT_Firmware_Date
Detect_HAT_Firmware_Date.py for all cameras with hat boards.  
```shell
python3 Detect_HAT_Firmware_Date.py -y <i2c-bus>
```
[Example]  
For pi4: 
```shell
python3 Detect_HAT_Firmware_Date.py -y 10
```

For Jetson:
Set i2c bus, for A02 is 6, for B01 is 7 or 8, for Jetson Xavier NX it is 9 and 10.
Xavier NX csi port 0:
```shell
python3 Detect_HAT_Firmware_Date.py -y 9
```


## register_debug_tool
register_debug_tool.sh use
```shell
./register_debug_tool.sh
```
By default, read and write 1000 times, if they are all "successful", it means there is no problem
