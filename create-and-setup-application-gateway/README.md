## Application Gateway with single Backend pool, routing rule, Listener and HTTP Settings.
---
For the sake of simplicity, this example uses a simple setup with a public front-end IP, a multi site listener to host a single site on this application gateway, an App service (function app) used for the backend pool, and a Path-Based request routing rule.

1. Let's start creating **Application Gateway**. Notice the Tier which is set to "Standard V2". For WAF policy to work with Application Gateway, we need to set the Tier as WAF V2

![](../images/1-create-application-gateway.png)


2. Create VNET and Subnet

![](../images/2-create-vnet.png)


3. Frontend is the IP address public or private. Every request will receive on this frontend and then proceed for further operations. Verify it's type is set to **Public**.

![](../images/3-create-frontend-public-ip.png)


**Note**: For the Application Gateway v2 SKU, you can only choose Public frontend IP configuration. Private frontend IP configuration is currently not enabled for this v2 SKU.

4. Click on "**Add a backend pool**" to add backend

![](../images/4-create-backend-pool.png)


5. Backend pool is used to route requests to the the backend servers whether it is Virtual machine or App service. Target type could be Virtual Machines, Virtual Machine scale set, IP address or FQDN (fully qualified domain name) or APP service. In this example, it will an App Service which is a function application.

![](../images/5-add-app-service-in-backendpool.png)

6. Next is to add routing rule. Click on + (plus) icon.

![](../images/6-create-routing-rule.png)


7. A routing rule requires a listener. We can configure Listener within the **Add routing rule** as shown in **Figure 7**. This listener will be the entry point for all request coming from Internet. It will listen on **Host name** which is <http://azurespring-demo.acloudtechie.com>.

![](../images/7-listener.png)


8. The HTTP setting will determine the behaviour of the routing rule. Configure HTTP setting and make sure the radio button "**Pick host name from backend target**" is selected. Since we've set **App Service** as Target type in backend pool so this HTTP setting will pick the host name from function app which is https://aspw-golangfunc-aen-nonprod.azurewebsites.net in this example.

![](../images/8-configure-http-settings.png)


9. Since our function app has three functions so adding Path based rules will help us to call APIs using URL we configured earlier in listener. for example:
   - **/api/foo**
   - **/api/bar**
   - **/api/baroof**

![](../images/9-create-routing-rule-for-apis.png)


10. Our configuration is completed so next is to validate the configurations and all the steps.

![](../images/10-app-gateway-configuration.png)


11. Validate, Review + Create

![](../images/11-validate-details.png)

---

## Thank You
Thank you for reading!

Follow me for more content at https://acloudtechie.com
Let's Grow together! [![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/bukotsunikki.svg?style=social&label=Follow%20%40zeeshanmcp12)](https://twitter.com/zeeshanmcp12)