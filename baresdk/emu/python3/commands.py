import random
from termcolor import colored
import os
import webbrowser
from kernel import process_management

usr = "pyuser"
os_version = "Pongo 1.2"
ui = "CLI"

class CommandProcessor:

    @staticmethod
    @process_management(priority=2)
    def showusr():
        print(usr)

    @staticmethod
    @process_management(priority=1)
    def exit():
        confirm = input("Are you sure you want to turn off the Hexrail system? (yes/no): ")
        if confirm.lower() == "yes":
            print("System turning off...")
            exit()
        else:
            print("Cancelled.")

    @staticmethod
    @process_management(priority=1)
    def cl():
      os.system("cls" if os.name == "nt" else "clear")

    @staticmethod
    @process_management(priority=1)
    def ls():
      print(os.listdir("."))
      
            else:
                print(colored(f"ERR"red"))
