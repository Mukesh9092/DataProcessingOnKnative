# Using Knative for Data Processing

#### Easy automated setup and cleanup for deploying a full PoC for ingestion --> messaging --> processing --> storing of large amounts of atomic data in a kubernetes cluster on Knative. 
---

### Prerequisites
  - Must have a kubernetes cluster configured and have its kubeconfig file to reach it
  - Must have the kubectl, and kubeless clients installed for your OS and architecture
  - Must have UNIX environment
  - Must have proper installion of Go with a $GOPATH setup.
  - Also clone the Knative/eventing repo under your $GOPATH/src folder
  - install the `ko` CLI to deploy Go source code as container images
  
### Config
  ##### One last bit of manual config you will need to do if you have a domain you would like to access the cluster through for ingestion is to copy the *config.yaml.example* file over and fill it out with your domain.
  You can do that with the following command.
  
  ```bash
  cp templates/config-domain.yaml.example templates/config-domain.yaml
  ```
  
  #### Now in the *config-domain.yaml* file change the `example.com` to your domain including any subdomains you prefer.
   

#### So this current implementation was built upon Knative v0.50, by the time this is published v0.60 has been released already, and by the time you are reading this, who knows which version. I had fun playing cat mouse, and trying to keep up with new releases since v.10, but eventually had to stop so I can make this repo. If you are intending to use a later version, this may not work for you 

If you have Knative v0.50 or a similar version installed you can skip straight to the Launching instructions, otherwise I have installation instructions below for Knative

### Knative Setup
  Not much to it, I have took the commands from the install doc and put them in a handy script for you.
  
    ```bash
    ./knative_setup.sh
    ```
    
 Sometimes you may have to run it twice if certain parts didn't successfully install
 
#### Next we move on to deploying the actual pipeline as shown below

### Launching
  Really you just need to do this and wait:
  
  ```bash
  ./deploy.sh
  ```
  
  You can check on your cluster afterwards with this:
  
  ```bash
  kubectl get pods --all-namespaces
  ```
  
  Here you will see all pods deployed (and some still being deployed)
  
  
### Cleanup/Undo
  If you have already deployed, you can clean it all up with this:
  
  ```bash
  ./cleanup.sh
  ```
  
  #### Note: Due to the time it takes kubernetes to add and remove resources, for best results, the cleanup and deploy scripts should not be run back to back without allowing a few minutes between runs.

