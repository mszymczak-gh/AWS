 _10/03/25 - 16/03/25_

Testing:
* test1
   * test 2
   * test 3
     * test 5
 
- test 4
   - test 5
      - test 9
 
 1. test 6
    - test 7



 Actions:

- Applied a cost-effective WAF rule setup
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
 
 
 File Extension Protection:
 - RestrictedExtensions_URIPATH: Blocks requests to files with dangerous extensions
 - RestrictedExtensions_QUERYARGUMENTS: Blocks query parameters containing dangerous file extensions
