import socket

address = ('172.16.10.44', 31500)
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

s.bind(address)
s.listen(5)

ss, addr = s.accept()
print 'got connected from',addr

#msg = raw_input()
#ss.send(msg)
while True:
    ra = ss.recv(512)
    print ra

ss.close()
s.close()
