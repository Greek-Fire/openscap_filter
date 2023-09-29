import socket

def scan_ip(ip, port):
    """
    Scans the given IP on the specified port.
    Returns True if the port is closed or there is no response,
    otherwise returns False.
    """
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(1)
    try:
        sock.connect((ip, port))
    except socket.error:
        return True  # Port is closed or no response
    return False  # Port is open

def main():
    closed_ports = []
    port = 22
    ip_range = ["192.168.1.{}".format(i) for i in range(1, 256)]  # replace with the range you want to scan
    
    for ip in ip_range:
        if scan_ip(ip, port):
            closed_ports.append(ip)
    
    if closed_ports:
        print("Hosts that are not listening on port 22:")
        for ip in closed_ports:
            print(ip)
    else:
        print("All hosts in the given range are listening on port 22")

if __name__ == "__main__":
    main()
