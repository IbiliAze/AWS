#!/bin/bash

aws s3api list-buckets #get chononical User ID

aws s3 presign s3://policiedbucket-devops-ibi/test.txt --expires-in 300 #presigned URL
