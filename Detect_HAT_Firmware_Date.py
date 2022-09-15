#!/usr/bin/python3
#
# Arducam raspberrypi/jetson fireware date generator.
# Copyright (C) 2022, Arducam.
#

import subprocess
import argparse
        
class Report:
    def __init__(self, csiport):
        self.csiport = csiport
    def run_cmd(self, cmd):
        try:
            p = subprocess.run(cmd, universal_newlines=True, check=False, shell=True,
                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            return p.stdout
        except RuntimeError as e:
            print(f'Error: {e}')
            
if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='fireware date generator')
    parser.add_argument('-y', help='csi port', type=int, required=True)
    args = parser.parse_args()
    
    i2caddress_Hat = 0x24
    i2caddress_year = 0x05
    i2caddress_month = 0x06
    i2caddress_date = 0x07
    
    csi = Report(args.y)
    year = csi.run_cmd("i2cget -y {} {} {}".format(args.y, i2caddress_Hat, i2caddress_year)).strip()
    month = csi.run_cmd("i2cget -y {} {} {}".format(args.y, i2caddress_Hat, i2caddress_month)).strip()
    date = csi.run_cmd("i2cget -y {} {} {}".format(args.y, i2caddress_Hat, i2caddress_date)).strip()

    year = "20" + str(int(year, 16))
    month = str(int(month, 16))
    date = str(int(date, 16))


    time = year + "-" + month + "-" + date
    print(time)
    
    
