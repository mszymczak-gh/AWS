## What & Why Web Application Firewall?

A web application firewall can be a software, a service, a device, an appliance which monitors and blocks traffic to and from your application. A WAF helps address the attack surface of the application security ecosystem. It can protect it from common attacks like SQL injection, cross-site scripting, DOS/DDOS, bot attacks, and zeroday attacks.

## What is AWS WAF & It's Features?

![image](https://github.com/user-attachments/assets/fa7af196-c93b-4bc0-a450-0ff81360cf0f)

WAF can protect based on the IP address, the rate of the requests, or the content.


WAF protects both AWS and on-premises applications.

![image](https://github.com/user-attachments/assets/c9da9f13-c7fb-48d8-ace8-26f3084a36b8)

## AWS WAF Components

The action can be configured to block, allow, or count, or even challenge with a captcha or anything else.

![image](https://github.com/user-attachments/assets/14e4642e-7561-456f-8ec3-9ff9f5034916)

## Evaluation Of Rules & Rule Groups

In the context of AWS WAF (Web Application Firewall), a Web ACL acts as a sophisticated traffic filter that:

When AWS WAF evaluates any web ACL or rule group against a web request, it evaluates the rules from the lowest numeric priority 

AWS WAF scans rules from the lowest number priority upwards and the rules have differenet priority levels, for example:
- Rule1 - priority 0
- RuleGroupA - priority 100
  - RuleA1 - priority 10,000
  - RuleA2 - priority 20,000
- Rule2 - priority 200
- RuleGroupB - priority 300
  - RuleB1 - priority 0
  - RuleB2 - priority 1

The AWS WAF would evaluate the rules for this web ACL in the following order:
- Rule1
- RuleGroupA RuleA1
- RuleGroupA RuleA2 
- Rule2
- RuleGroupB RuleB1
- RuleGroupB RuleB2

![image](https://github.com/user-attachments/assets/a0e9ef64-b72e-4350-aae3-a97bafb71a00)

If a rule in the web ACL finds a match for a request and the action is a terminating action, that match determines the final disposition of the web request and the WAF doesn't process any other rules in the web ACL.

## Web ACL Capacity Unites (WCUs)

Used to calculate and control the operating resources needed to run rules, rule groups, and web ACLs.

- Rule WCU - to reflect each rule's relative cost
- Rule Group WCU - determined by the rules that re defined inside the rule group, max capacity 5000 WCUs
- Web ACL WCUs - determined by the rule or rule groups inside the web ACL. The basic price for web ACL includes 1500 WCU, Mac capacity 5000 WCU

Practical implications:
- More complex security = More WCUs consumed
- You can't just add infinite complex rules
- Must design efficient, targeted security rules

![image](https://github.com/user-attachments/assets/b2ff2f8f-52b6-4573-8118-7f6686d869db)

