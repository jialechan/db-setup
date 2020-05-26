# db-setup
## 设置cloud9环境
```shell
curl https://raw.githubusercontent.com/jialechan/db-setup/master/cloud9Setup.sh | bash
```
## 克隆项目
```shell
git clone git clone https://github.com/jialechan/db-setup.git
```
## 使用cdk创建db ec2
```shell
cd db-testing-setup
vim config.yaml
npm install
cdk deploy
```
## 生成db-server.pem
```shell
# 略
chmod 400 db-server.pem
```
## 进入db-server
```shell
ssh -i db-server.com ec2-user@1.2.3.4
curl https://raw.githubusercontent.com/jialechan/db-setup/master/amazonLinuxSetup.sh | bash
git clone https://github.com/jialechan/db-setup.git
cd db-setup/db-docker-compose
./setup.sh
./up.sh
```