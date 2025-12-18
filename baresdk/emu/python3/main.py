import os 
import sys
import time
import commands
from datetime import date
from termcolor import colored
from commands import CommandProcessor
from kernel import Kernel

cp = CommandProcessor()

def loading():
    for i in range(0, 101):
        time.sleep(0.0099)
        sys.stdout.write("\rStarting.. " + str(i) + "%")
        sys.stdout.flush()

system_commands = [
    'cp.ls',
    'cp.cl',
    'cp.usrdata'
]

kernel = Kernel()

loading()

c = colored
print(c("THIS IS A SANDBOX-SPACE AND ITS NOT AN REAL ENVIRONMENT!", "yellow"))
print("THIS IS AN REALLY-LIMITED ENVIRONMENT. PLEASE USE REAL EMULATORS TO GET FULL FUNCTIONALITY.")

today = date.today()
c = colored
while True:
    user_input = input(f"> ").split(" ")
    entered_command = user_input[0]
    args = user_input[1:]
    
    command_found = False
    
    for command_str in system_commands:
        command_name = command_str.split('.')[-1]
        if command_name == entered_command:
            try:
                command_func = eval(command_str)
                command_func(*args)
                command_found = True
                break
            except Exception as e:
                print(f"Error while executing the command '{entered_command}': {e}")
                break
    if not command_found:
        print(f"ERR")
