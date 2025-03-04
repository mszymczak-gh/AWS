_24/03/25 - 28/03/28_

Actions:
- Selected [A Monk in Cloud's tutorial] (https://www.youtube.com/watch?v=qpaDbXcPwnU&list=PLjl2dJMjkDjnwCR6eTLBhjt_45Ua7N9vn) on hosting a serverless web application on AWS.
- Created a simple static web page with bolt.new > Deployed it with Netlify and downloaded the files from this.
- Half-way through the tutorial, the website should have been able to launch however access was denied:
  
![image](https://github.com/user-attachments/assets/4a2b261f-ddba-40e7-8dcf-8c3041f5cf0b)

- CloudFront's origin access was set to OAC and the bucket policy's version had 2008-10-17 mentioned however 2012-10-17 was advised. Neither seemed to work.
- Resolved access denied issue by changing file structure > The dist folders were contained in a [deploy folder]() and that was uploaded first as the root folder.
- Issue remaining is that the shows a blank page. Tab is called _Vite + React + TS_
- Changed everything CloudFront to public. On S3, I changed **Static website hosting** and **Block all public access** off.
- Deleted the bucket, CloudFront, hosted zone, and SSL certificates and started from the beginning.
- Reversed changes to make it block public access etc.

![image](https://github.com/user-attachments/assets/9442ce05-660d-4fd4-80d7-73115064cbaa)

- Replaced the dist files with the source files from bolt [project](). This is an issue as the server requires the fully built dist files (short for distribution).
- Prompted bolt to upload the correct contents to the dist folder which was empty before. Uploaded these files to S3 without a parent folder, issue still persisted.
- Followed [Ibrahim's guide](https://medium.com/@brahimdeiza/easy-way-to-host-a-website-on-aws-full-guide-b690b4763f34) on Medium. Order of setup was different: Route 53, S3 Bucket, ACM, then CloudFront.
- Set everything up according to the article and it is accessible via [testingstaticwebsite.co.uk](testingstaticwebsite.co.uk) and the subdomain www.testingstaticwebsite.co.uk.
