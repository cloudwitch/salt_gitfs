import socket
# define hostname
hostname = socket.gethostname()

# If hostname contains "k8s" assign the role "master" for 01, else "worker".
def get_k8s_name():
    k8s_role_dict = {'k8s role': ''}
    if 'k8s' in hostname:
        if '01' in hostname:
            k8s_role_dict['k8s role'] = 'master'
        else:
            k8s_role_dict['k8s role'] = 'worker'
        return k8s_role_dict