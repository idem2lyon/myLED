#!/usr/bin/python
#-*- coding: utf-8 -*-
################################################################################
# PROJECT: myLED - FILE: myLED.py - CREATION: 2015/05/04
# Ce fichier est sous licence GPL.
# $Id$
################################################################################
"""
Gestion des 3 LEDs en facade
Info : 
  LED Rouge sur Pin 26
  LED Verte sur Pin 21
  LED Bleue sur Pin 20 

U{http://geekandmore.fr/}.

@version: 1.0
@author: U{Mehdi HAMIDA (idem) <idem@geekandmore.fr>}
"""

# Python libraries
import RPi.GPIO as GPIO
import time as time
import os
import signal
import sys
import argparse

# Define mode to access GPIO pins
GPIO.setmode(GPIO.BCM)
#GPIO.cleanup()

# pin id for the LED status
rouge=26      # LED Rouge
verte=21      # LED Verte
bleue=20      # LED Bleue

# GPIO Setup.
GPIO.setwarnings(False)

GPIO.setup(rouge, GPIO.OUT)
GPIO.setup(verte, GPIO.OUT)
GPIO.setup(bleue, GPIO.OUT)

def message(i):
  print i

def Allumer(couleur):
  pin_led='couleur'
  if couleur == 'rouge':
    pin_led=26
  elif couleur == 'verte':
    pin_led=21
  elif couleur == 'bleue':
    pin_led=20
  else:
    message('La couleur doit être rouge, verte ou bleue')
    GPIO.output(pin_led,True)

def Eteindre(couleur):
  pin_led='couleur'
  if couleur == 'rouge':
    pin_led=26
  elif couleur == 'verte':
    pin_led=21
  elif couleur == 'bleue':
    pin_led=20
  else:
    message('La couleur doit être rouge, verte ou bleue')
  GPIO.output(pin_led,False)

try:
  if __name__ == '__main__':
    print 'sys.argv: ', sys.argv
    if len(sys.argv) == 3:
      message(sys.argv[1])
      message(sys.argv[2])
      action = sys.argv[1]
      couleur = sys.argv[2]
      if action == 'Allumer':
        Allumer(couleur)
      elif action == 'Eteindre':
        Eteindre(couleur)
      else:
        message('Le parametre action doit être Allumer ou Eteindre')
    else:
      message('Il faut 2 arguments')

except KeyboardInterrupt:
  print "  Quit"
  # Reset GPIO 
  GPIO.cleanup()
