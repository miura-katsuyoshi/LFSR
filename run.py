"""
Testbench of LFSR.sv
------------------------
usage: ./run.py
"""

import os
import subprocess
from vunit.verilog import VUnit

if not os.path.isdir("src"):
    os.mkdir("src")
for width in range(5,25):
    subprocess.run("sed -e 's/%WIDTH%/{}/' LFSR_tb.sv > src/LFSR{}_tb.sv".format(width,width), shell=True);

VU = VUnit.from_argv()
lib = VU.add_library("lib");

# Design
lib.add_source_files("LFSR.sv")

# Testbench
lib.add_source_files("src/*.sv")

VU.main()
