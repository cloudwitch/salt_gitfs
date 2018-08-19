import socket
hostname = socket.gethostname()
if 'k8s' in hostname:
  def k8s_grain():
    grains = {}
    grains[role] = 'master'
    if '01' in hostname:
      role = 'master'
    else:
      role = 'worker'
    k8s = {'role': role, 'cluster': 'k8spi'}
    return k8s
  print(k8s)

else:
  print("Not a k8s node, no cluster for you")


