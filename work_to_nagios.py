#!/bin/python
# -*- coding: utf-8 -*-

########################################################
### reads file to produce quick nagios .cfg file     ###
### file initially generated with a grep'd nmap      ###
########################################################


f=  open("work_machines","r")


for i in f :
    addr = i.split()
    

    nm = addr[4]
    nam = nm.split(".")
    
    ip = addr[5].translate(None,'()')

    print ip    
    
    name = nam[0]

    fi = open('%s.cfg' % name,"w+")
    fi.write("define host {\n")
    fi.write("\tuse\tgeneric-host\n")
    fi.write("\thost_name\t%s\n" % name)
    fi.write("\talias\t%s\n" % name)
    fi.write("\taddress\t%s\n" %ip)
    fi.write("\t}\n\n\n")

  
##############################################    
    
    
    fi.write("define service {\n")
    fi.write("\tuse\tgeneric-service-nomail\n")
    fi.write("\thost_name\t%s\n" % name)
    fi.write("\tservice_description\tDisk Space\n")
    fi.write("\tcheck_command\tcheck_disk!80!90!/\n")
    fi.write("\t}\n\n\n")
            
##############################################    
    
    
    fi.write("define service {\n")
    fi.write("\tuse\tgeneric-service-nomail\n")
    fi.write("\thost_name\t%s\n" % name)
    fi.write("\tservice_description\tCurrent Users\n")
    fi.write("\tcheck_command\tcheck_users!20!50\n")
    fi.write("\t}\n\n\n")

##############################################    
    
    
    fi.write("define service {\n")
    fi.write("\tuse\tgeneric-service-nomail\n")
    fi.write("\thost_name\t%s\n" % name)
    fi.write("\tservice_description\tTotalProcesses\n")
    fi.write("\tcheck_command\tcheck_procs!250!400/\n")
    fi.write("\t}\n\n\n")


##############################################    
    
    
    fi.write("define service {\n")
    fi.write("\tuse\tgeneric-service-nomail\n")
    fi.write("\thost_name\t%s\n" % name)
    fi.write("\tservice_description\tCurrent Load\n")
    fi.write("\tcheck_command\tcheck_load!5.0!4.0!3.0!10.0!6.0!4.0/\n")
    fi.write("\t}\n\n\n")
    
    
    
print "Done!"    