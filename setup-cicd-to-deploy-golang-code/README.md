## Setup Build and Release Pipeline to deploy code
In this example, our goal is to deploy *Azure function* written in golang.

**Custom Handler** feature has been generally available since late 2020 so we will be using the same custom handler to develop Azure functions written in golang.

[goazurefun](https://github.com/zeeshanmcp12/goazurefun) repo is used to host functions written in golang. We have three very basic functions that returns string and one of them a JSON data. These are the three functions:
- /getname
- /greetings
- /getprofile

We will host all three functions in single Function app and deploy it using build and release pipeline.

---
### Setup Build Pipeline

1. This task is used to install go version on pipeline agent.
   
![](../images/17-ci-pipeline-go-tool-installer.png)

2. This task will be running *go get* and download the packages along with their dependencies.


![](../images/18-ci-pipeline-go-get-in-agent.png)


3. This task will run *go build* command which compiles the packages and their dependencies in a single executable file.

![](../images/19-ci-pipeline-go-build-exe.png)

4. Next we use the *Archive Files* task to create an archive file from a source folder.

![](../images/20-archive-files.png)

5. Finally, we use the *Publish Build Artifacts* task to publish build artifact to DevOps pipelines.

![](../images/21-publish-artifacts.png)


---
### Setup Release Pipeline

1. Create Release pipeline and add artifacts. In this example, it is **_CI-HandlerFunc-AzureSpring**
![](../images/22-cd-pipeline-add-artifact-stage.png)


2. Add Azure App service manage task which will stop the function app.

![](../images/23-azure-app-service-manage-task.png)


3. Add Azure App service deploy task that will deploy the code from publised artifact to Azure function app.

![](../images/24-azure-app-service-deploy-task.png)


4. Add Azure App service manage task which will start the function app again once the deployment is completed.

![](../images/25-azure-app-service-manage-task.png)


5. In previous tasks, we used $(golang_func_app) variable in many places. It's value is defined in variables section.

![](../images/26-override-values-in-variables.png)


6. Once everything is configured then execute the deployment and see the results.

![](../images/27-successfully-deployed.png)

---

## Thank You
Thank you for reading!

Follow me for more content at https://acloudtechie.com
Let's Grow together! [![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/bukotsunikki.svg?style=social&label=Follow%20%40zeeshanmcp12)](https://twitter.com/zeeshanmcp12)