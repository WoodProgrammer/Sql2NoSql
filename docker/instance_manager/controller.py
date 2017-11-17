import docker
import threading
import time
import re
cli = docker.from_env()
max_instance_count = 10
flag = 1


def machine_logger():
    global flag
    while True:

        container_lists = cli.networks.get("8741bd2a4bf19fc44e2ee5827230abb088fd039502089f872e27d2b910adcefc").containers


        for container in container_lists:
          
            data = cli.containers.get(container.id).exec_run(cmd="df --output=pcent /data/db ")      
            disk_usage_data = re.findall("\d+",data)
            print disk_usage_data[0]
            try:
                if int(disk_usage_data[0]) >= 77:
                    flag = 0
                    print "WARNIN Disk usage  {} :    {}".format(container.id,disk_usage_data[0])
                    print "New Container Creating ..... "
                else:
                    print "Disk usage of {} {}".format(container.id,disk_usage_data)
            except:

                print "Disk usage data cannot reachable {}".format(container.id)    
            time.sleep(1)





def create_container():
    try:
        cli.containers.run("mongo")
        exit(1)
    except:
        pass



def config_listener():
    
    global flag
    counter = 0
    while True:
        if counter == max_instance_count or flag == 1:
            print "Waiting for request"
            time.sleep(1)
        elif flag == 0:
            print "Containering"
            threading.Thread(target=create_container,args=()).start()
            flag = 1

threading.Thread(target=machine_logger,args=()).start()
config_listener()
