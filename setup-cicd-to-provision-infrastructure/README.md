## Application Gateway with single Backend pool, routing rule, Listener and HTTP Settings.

1. Let's start creating **Application Gateway**. Notice the Tier which is set to "Standard V2". For WAF policy to work with Application Gateway, we need to set the Tier as WAF V2
![](../images/1-create-application-gateway.png)

2. Create VNET and Subnet
![](../images/2-create-vnet.png)

3. Frontend is the IP address public or private. Every request will receive on frontend and then proceed for further operations.
![](../images/3-create-frontend-public-ip.png)

4. Click on "**Add a backend pool**" to add backend
![](../images/4-create-backend-pool.png)

5. Backend pool is the place where we can configure our backend either it is Virtual machine, App Service (Function / Web App) or Virtual Machine scale set.
![](../images/5-add-app-service-in-backendpool.png)

6. Next is to add routing rule. Click on + (plus) icon.
![](../images/6-create-routing-rule.png)

7. Configure Listener as shown in Figure 7. This listener will be the entry point for all request coming from Internet. It will listen on **Host name** which is azurespring-demo.acloudtechie.com . Next is to add HTTP Setting.
![](../images/7-listener.png)

8. Configure HTTP setting and make sure the radio button "Pick host name from backend target" is selected. Since we've added App Service in backend pool so this HTTP setting will pick the host name of function app which is https://aspw-golangfunc-aen-nonprod.azurewebsites.net in our case.
![](../images/8-configure-http-settings.png)

9. This rule will be based on Path-Based which means here we will define * (wildcard) so it can support all APIs with this URL path. for example:
   - /api/foo
   - /api/bar
   - /api/baroof
![](../images/9-create-routing-rule-for-apis.png)

10. Our configuration is completed so next is to validate the configurations and all steps.
![](../images/10-app-gateway-configuration.png)

11. Validate, Review + Create
![](../images/11-validate-details.png)
