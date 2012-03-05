#!/usr/bin/env python
"""
SYNOPSIS

    runonsave.py COMMAND 

DESCRIPTION

    Runs a command when a file in the current working directory or its subdirectory is changed.

EXAMPLES

    runonsave.py pdflatex cv.tex 

AUTHOR

    Leonard Ehrenfried <leonard.ehrenfried@web.de>

"""

import os, sys, subprocess, time

SCAN_INTERVAL=5
EXCLUDES=['.git', '.hg', '.svn', 'CVS','target' ]

def main ():
  cwd = os.getcwd()
  last_run=os.path.getmtime(cwd)
  while(True):
    last_modified=get_last_modified(cwd)
    if (last_modified > last_run):
      args=sys.argv
      
      #strip out the python command
      if args[0] is "python":
        args=args[1:]
      args=args[1:]

      print "*** Save detected: running %s ***" % " ".join(args)
      subprocess.Popen(args)
      print "*** Finished ***"
      last_run=last_modified
    time.sleep(SCAN_INTERVAL)

def get_last_modified(current_dir):
    """Recurses though a directory tree and finds the newest last modified date"""
    #print current_dir 
    last_modified=os.path.getmtime(current_dir)
    # if it is a directory recurse into it 
    if os.path.isdir(current_dir):
      subdirs=os.listdir(current_dir)
      subdirs = [subdir for subdir in subdirs if should_check(current_dir+"/"+subdir)]

      for subdir in subdirs:
        temp_last_modified=get_last_modified(current_dir+"/"+subdir)
        if(temp_last_modified>last_modified):
          last_modified=temp_last_modified

    return last_modified

def should_check(path):
  """Checks if path should be recursively searched. Excludes files and SCM dirs"""
  if(os.path.isdir(path)):
    basename=os.path.basename(path)
    if basename not in EXCLUDES:
      return True
    else:
      return False
  return True 

if __name__ == '__main__':
  main()

