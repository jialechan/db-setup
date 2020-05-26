import * as fs from 'fs';
import * as cdk from '@aws-cdk/core';
import * as ec2 from '@aws-cdk/aws-ec2';
import YAML = require('yaml')

export class DbTestingSetupStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const config = YAML.parse(fs.readFileSync('config.yaml', 'utf8'))

    const vpcId = config.vpcId;
    if (typeof vpcId === "undefined") {
      throw new Error('请设置vpcId到环境变量');
    }

    const keyName = config.keyName;
    if (typeof keyName === "undefined") {
      throw new Error('请设置keyName到环境变量');
    }

    const allowFromIps = config.allowFromIps;

    const vpc = ec2.Vpc.fromLookup(this, 'VPC', {
      vpcId
    });

    const db = new ec2.Instance(this, 'db-instance', {
      vpc,
      vpcSubnets: { subnetType: ec2.SubnetType.PUBLIC },
      keyName,
      instanceType: ec2.InstanceType.of(ec2.InstanceClass.T3, ec2.InstanceSize.LARGE),
      machineImage: ec2.MachineImage.latestAmazonLinux({
        generation: ec2.AmazonLinuxGeneration.AMAZON_LINUX_2
      }),
      blockDevices: [{
        deviceName: '/dev/xvda',
        volume: ec2.BlockDeviceVolume.ebs(200),
      }]
    });

    db.connections.allowFrom(ec2.Peer.ipv4(vpc.vpcCidrBlock), ec2.Port.allTraffic()); // 内网全部通

    // 设置自定义开放的ip
    if (typeof allowFromIps !== "undefined") {
      for (let ip of allowFromIps) {
        if (ip) {
          db.connections.allowFrom(ec2.Peer.ipv4(ip), ec2.Port.allTraffic());
        }
      }
    }

    new cdk.CfnOutput(this, 'instancePrivateIp', { value: db.instancePrivateIp });
    new cdk.CfnOutput(this, 'instancePublicIp', { value: db.instancePublicIp });

  }
}
