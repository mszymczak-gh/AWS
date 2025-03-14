 _10/03/25 - 15/03/25_

 Actions:
 
 - Applied a cost-effective WAF rule setup (777/5000 WCUs). List is in order of priority:

1. **Geo-Restriction Rule** blocks IP addresses from specific countries (1 WCUs)
   - Name = GeoRestriction
   - If a request = matches the statement
   - Inspect = Originates from a country in
   - Country codes = China, Russia, North Korea
   - IP address to use to determine the country of origin = Source IP address
   - Action = Block

2. **Access Control List Rule (HTTP Method Restriction)** blocks unauthorized HTTP methods (4 WCUs)
   - Name = AllowOnlyGetHead
   - If a request = doesn't match the statement (NOT)
   - Inspect = HTTP method
   - Match type = Exactly matches string
   - String to match = GET
   - Text transformation = None
   - Action = Block

3. **Rate-Based Rule** protects against brute force and DDoS attempts (2 WCUs)
   - Name = RateLimiteRule
   - Type = Rate-based rule
   - Rate limit = 100
   - Evaluation windows = 5 minutess (300 seconds)
   - Request aggregation = Source IP address
   - Scope of inspection and rate limiting = Consider all requests
   - Action = Block

4. **Custom Bad Bot Rule** reduces unnecessary processing of malicious traffic (100 WCUs)
   - Name = BadBotBlocker
   - If a request = matches at least one of the statements (OR)
   - Inspect = Single header
   - Header field name = user-agent
   - Match type = Contains string
   - String to match = crawl + slurp + spider + bot + scrape + curl + wget
   - Action = Block


5. **AWS Managed Core Rule Set** provides protection against common vulnerabilities like XSS and SQL injection (700 WCUs)
   - Header Protection Rules:
     - NoUserAgent_HEADER: Blocks requests with no User-Agent header
     - UserAgent_BadBots_HEADER: Blocks requests from known malicious user agents
 
   - Size Restriction Rules:
     - SizeRestrictions_QUERYSTRING: Blocks abnormally large query strings
     - SizeRestrictions_Cookie_HEADER: Blocks cookies exceeding size limits
     - SizeRestrictions_BODY: Blocks requests with unusually large bodies
     - SizeRestrictions_URIPATH: Blocks URIs with excessive length
  
   - Cross-Site Request Forgery (CSRF) Protection:
     - EC2MetaDataSSRF_BODY: Prevents Server-Side Request Forgery attacks targeting EC2 metadata
     - EC2MetaDataSSRF_COOKIE: Similar protection for cookie-based SSRF
     - EC2MetaDataSSRF_URIPATH: Protection against SSRF in URI paths
     - EC2MetaDataSSRF_QUERYARGUMENTS: Protection against SSRF in query parameters
  
   - File Inclusion Protection:
     - GenericLFI_QUERYARGUMENTS: Blocks Local File Inclusion attempts in query parameters
     - GenericLFI_URIPATH: Blocks Local File Inclusion attempts in URI paths
     - GenericLFI_BODY: Blocks Local File Inclusion attempts in request bodies
  
   - File Extension Protection:
     - RestrictedExtensions_URIPATH: Blocks requests to files with dangerous extensions
     - RestrictedExtensions_QUERYARGUMENTS: Blocks query parameters containing dangerous file extensions
    
   - RFI Protection Rules:
     - GenericRFI_QUERYARGUMENTS: Blocks Remote File Inclusion attacks in query parameters
     - GenericRFI_BODY: Blocks RFI attacks in request bodies
     - GenericRFI_URIPATH: Blocks RFI attacks in URI paths
 
   - XSS Protection Rules:
     - CrossSiteScripting_COOKIE: Blocks XSS attacks via cookies
     - CrossSiteScripting_QUERYARGUMENTS: Blocks XSS attacks in query parameters
     - CrossSiteScripting_BODY: Blocks XSS attacks in request bodies
     - CrossSiteScripting_URIPATH: Blocks XSS attempts in URI paths
   
- Created a CloudWatch and connected it in WAF for logging and metrics.
- Website became unaccessible after deploying WAF. 

![image](https://github.com/user-attachments/assets/6ee1d090-ca30-49a0-b05a-f7907b863d72)

- Sampled Requests from WAF and All metrics from CloudWatch showed that AllowOnlyGetHead2 is causing the block. This rule restricts only HEAD HTTP requests.
- The rules **IF NOT(Method=GET) THEN Block** and **IF NOT(Method=HEAD) THEN Block** are separated with AllowOnlyGetHead and AllowOnlyGetHead2 respectively.
- The GET request is being allowed through the 1st rule but is blocked by the 2nd.

![image](https://github.com/user-attachments/assets/250a0735-f159-48f3-9b83-3598df9f1910)

- Same error '_Error from cloudfront_' occurs for:
  - curl -v https://testingstaticwebsite.co.uk
  - curl -I https://testingstaticwebsite.co.uk
- It's not suitable to reverse the rule to IF (Method=HEAD) THEN Allow and setting the default action as Block because the rest of the rules rely on it being Allow.
- I was not able to configure 1 rule to include both the GET and HEAD strings which would have resolved the issue. The console has limitations so I created [the rule](JSON_Rule_Definition.json) using the JSON editor.

![image](https://github.com/user-attachments/assets/e822eee1-a6d3-436f-b6c8-97451a56c739)

- GET requests work as I can access the site. HEAD requests work, tested this in CLI.

-A "Mozilla/5.0" avoids triggering the BadBotBlocker2 rule.

![image](https://github.com/user-attachments/assets/3e558202-13f5-412c-9b99-cbec2ca707df)

![image](https://github.com/user-attachments/assets/85bd18d9-b570-41fc-8e21-a0d4d5ad2c81)

- Tested the AWS-AWSManagedRulesCommonRuleSet by typing https://testingstaticwebsite.co.uk/?s=<script>alert(document.cookie);</script>
- The BadBotBlocker2 blocked this request.

![image](https://github.com/user-attachments/assets/7a4ab3b7-41c1-4a67-9612-56c84075278a)

- Tested the RateLimitRule using a [bash script]() which send curl requests in a loop. This caused the site to go down and CLoudWatch picked it up.

![image](https://github.com/user-attachments/assets/feee9270-5275-43a7-af34-29075391fd16)
 

![image](https://github.com/user-attachments/assets/d4adc459-94f0-4dfb-91ab-6a673c6c5123)
