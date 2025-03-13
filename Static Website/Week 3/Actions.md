 _10/03/25 - 15/03/25_

 Actions:
 
 - Applied a cost-effective WAF rule setup (777/5000 WCUs). List is in order of priority:

1. **Geo-Restriction Rule** blocks IP addresses originating from specified countries (1 WCUs)
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
   
- Created a CloudWatch and connecting it in WAF on the Logging and metrics tab
- 
