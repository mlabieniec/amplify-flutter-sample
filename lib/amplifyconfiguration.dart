const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "analytics": {
        "plugins": {
            "awsPinpointAnalyticsPlugin": {
                "pinpointAnalytics": {
                    "appId": "66d0a979d5214bb4bc71e114bc737fd7",
                    "region": "us-east-1"
                },
                "pinpointTargeting": {
                    "region": "us-east-1"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "us-east-2:b3409901-af25-47c0-93fd-ed6f8d166deb",
                            "Region": "us-east-2"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-2_2DGei7fXr",
                        "AppClientId": "1qujphjsbv34no2l0ialj7nh5d",
                        "AppClientSecret": "hp36pnrqjfr0brftkequ3pb5erlc9m3tvrtopjk1rev7pd0e9ck",
                        "Region": "us-east-2"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH"
                    }
                },
                "PinpointAnalytics": {
                    "Default": {
                        "AppId": "66d0a979d5214bb4bc71e114bc737fd7",
                        "Region": "us-east-1"
                    }
                },
                "PinpointTargeting": {
                    "Default": {
                        "Region": "us-east-1"
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "flutterphotos1882ae338e4f44709dc277cbfa238067171544-dev",
                        "Region": "us-east-2"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "flutterphotos1882ae338e4f44709dc277cbfa238067171544-dev",
                "region": "us-east-2",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';