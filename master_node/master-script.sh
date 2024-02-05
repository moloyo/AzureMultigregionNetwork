echo "Download containerd package"
wget https://github.com/containerd/containerd/releases/download/v1.6.14/containerd-1.6.14-linux-amd64.tar.gz

echo "Unpack containerd package"
sudo tar Cxzvf /usr/local containerd-1.6.14-linux-amd64.tar.gz

echo "Install runc"
wget https://github.com/opencontainers/runc/releases/download/v1.1.3/runc.amd64
sudo install -m 755 runc.amd64 /usr/local/sbin/runc

echo "Download and install CNI plugins"
wget https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz
sudo mkdir -p /opt/cni/bin
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz

echo "Configure containerd"
sudo mkdir /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
sudo curl -L https://raw.githubusercontent.com/containerd/containerd/main/containerd.service -o /etc/systemd/system/containerd.service

echo "Start containerd"
sudo systemctl daemon-reload
sudo systemctl enable --now containerd

echo "kubelet,kubectl,kubeadm installation"
sudo apt update
sudo apt-get install -y apt-transport-https ca-certificates curl
curl -L https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add
sudo touch /etc/apt/sources.list.d/kubernetes.list
sudo chmod 666 /etc/apt/sources.list.d/kubernetes.list
sudo echo deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://apt.kubernetes.io/ kubernetes-xenial main | tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl

echo "Run kubeadm init and setup the control plane"
sudo kubeadm init --ignore-preflight-errors=all --token ${token}
export KUBECONFIG=/etc/kubernetes/admin.conf
echo 'KUBECONFIG=/etc/kubernetes/admin.conf' >> /etc/environment
kubectl get nodes
kubectl get pods --all-namespaces
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
kubectl get pods --all-namespaces
kubectl get nodes