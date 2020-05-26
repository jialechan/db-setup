#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from '@aws-cdk/core';
import { DbTestingSetupStack } from '../lib/db_testing_setup-stack';

const app = new cdk.App();
new DbTestingSetupStack(app, 'DbTestingSetupStack',{ 
  env: { 
    account: process.env.CDK_DEFAULT_ACCOUNT, 
    region: process.env.CDK_DEFAULT_REGION 
  }
});
