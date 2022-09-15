#!/usr/bin/python3
#
# Arducam raspberrypi/jetson fireware date generator.
# Copyright (C) 2022, Arducam.
#

        
 class Report:
    def __init__(self, csiport):
        self.csiport = csiport
    def run_cmd(cmd):
        try:
            p = subprocess.run(cmd, universal_newlines=True, check=False, shell=True,
                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            return p
        except RuntimeError as e:
            print(f'Error: {e}')
            
if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='fireware date generator')
    parser.add_argument('-y', help='csi port', type=int)
    args = parser.parse_args()
    
    i2caddress_Hat = 0x24
    i2caddress_year = 0x05
    i2caddress_month = 0x06
    i2caddress_date = 0x05
    
    csi = Report(args.y)
    year = csi.run_cmd("i2cget -y {} {} {}".format(args.o, i2caddress_Hat, i2caddress_year))
    month = csi.run_cmd("i2cget -y {} {} {}".format(args.o, i2caddress_Hat, i2caddress_month))
    date = csi.run_cmd("i2cget -y {} {} {}".format(args.o, i2caddress_Hat, i2caddress_date))
    print(year)
    print(month)
    print(date)
    
    
