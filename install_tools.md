# Install AWS CLI, eksctl, and kubectl

## AWS CLI

### Step 1: Download the AWS CLI Installer

We'll use  curl  to download the AWS CLI installer for macOS.

```bash
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
```

### Step 2: Install the AWS CLI

Now, we'll use the  installer  command to install the downloaded package.

```bash
sudo installer -pkg AWSCLIV2.pkg -target /
```

### Step 3: Verify the Installation

Finally, let's verify that the AWS CLI is installed correctly by checking its version.

```bash
aws --version
```

## Install eksctl

```bash
brew install eksctl
```

### Configure AWS

```bash
mkdir -p ~/.aws && echo "[default]
region = us-east-1" > ~/.aws/config
```

### Install Kubectl

[Get kubectl from Amazon](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html)

```bash
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.32.0/2025-01-10/bin/darwin/amd64/kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.32.0/2025-01-10/bin/darwin/amd64/kubectl.sha256
openssl sha1 -sha256 kubectl
cat kubectl.sha256
```
