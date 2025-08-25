# How to Handle Config Files

When you create a new Kubernetes cluster using Terraform and the Vultr provider, the kubeconfig file is provided as a base64-encoded string. To use this configuration with `kubectl`, you need to decode it and merge it with your existing kubeconfig file.
### 1\. Decode the Kubeconfig

The `base64` command is a standard tool on most Linux and macOS systems. You can use it in a one-liner to both decode the output and save it to a file.

First, run this command to get the raw base64 string and pass it to the `base64` decoder.

```bash
tofu output -raw kubeconfig | base64 -d > ./new-vultr-cluster.yaml
```

  * `tofu output -raw kubeconfig` gets the raw base64 string.
  * The `|` (pipe) sends that string as input to the next command.
  * `base64 -d` decodes the input string.
  * `>` redirects the decoded output to your file.

-----

### 2\. Merge and Clean Up

Now that you have a valid YAML file, you can run the commands you tried before to merge it with your main configuration.

```bash
# This command merges the new config file into your main kubeconfig file
KUBECONFIG=~/.kube/config:./new-vultr-cluster.yaml kubectl config view --flatten > ~/.kube/merged-config

# This command replaces your old config with the new, merged one
mv ~/.kube/merged-config ~/.kube/config

# Remove the temporary file
rm ./new-vultr-cluster.yaml
```

After these steps, your `~/.kube/config` file will be updated with the details of your new Vultr cluster, and you'll be able to switch to it using `kubectl config use-context`.

-----
There are two primary `kubectl` commands you'll use to manage multiple clusters: `kubectl config get-contexts` to view them, and `kubectl config use-context` to switch between them.

-----

### 1\. View Clusters

To see a list of all the clusters configured in your `~/.kube/config` file, you'll use the `get-contexts` command.

```bash
kubectl config get-contexts
```

When you run this, you'll see a table listing all your clusters. The output will look something like this:

```
CURRENT   NAME           CLUSTER      AUTHINFO
* minikube       minikube     minikube
          vultr-cluster  vultr-vke    vultr-user
```

The asterisk `*` in the `CURRENT` column indicates which cluster is currently active. In this example, it's `minikube`.

-----

### 2\. Switch Clusters

To change which cluster you are actively working with, you will use the `use-context` command, followed by the name of the cluster you want to switch to.

```bash
kubectl config use-context <cluster-name>
```

For example, to switch to your Vultr cluster, you would run:

```bash
kubectl config use-context vultr-cluster
```

Now, any `kubectl` commands you run (like `kubectl get nodes`) will be sent to your Vultr cluster.

-----

### How the Commands Work

The commands you listed are a powerful way to manage multiple configurations. Here's a detailed breakdown of what each part does:

1.  **`KUBECONFIG=~/.kube/config:./new-vultr-cluster.yaml`**

      * This is not a standalone command; it's an **environment variable assignment** that only applies to the command immediately following it.
      * `KUBECONFIG` is the variable that tells `kubectl` where to find its configuration files.
      * By setting it like this, you're telling `kubectl` to look at **two separate files** for its configuration: your existing `~/.kube/config` and the new `./new-vultr-cluster.yaml` file. The colon `:` is the separator.

2.  **`kubectl config view --flatten`**

      * `kubectl config view` is the command that prints the content of your configuration files.
      * `--flatten` is a flag that tells `kubectl` to take all the separate configurations from the files listed in `KUBECONFIG`, merge them into a single, cohesive configuration, and then print that combined result.

3.  **`> ~/.kube/merged-config`**

      * The `>` is a **redirection operator**. It tells your terminal to take the output from the previous command (`kubectl config view --flatten`) and write it into a file, instead of printing it to the screen. In this case, it's saving the merged configuration into a temporary file named `merged-config`.

4.  **`mv ~/.kube/merged-config ~/.kube/config`**

      * `mv` stands for "move."
      * This command is used to **replace your original configuration file** with the new, merged one. It moves the `merged-config` file and renames it to `config`, overwriting the old one.

5.  **`rm ./new-vultr-cluster.yaml`**

      * `rm` stands for "remove."
      * This command simply **deletes the temporary file** you created in the first step. It's a good practice to clean up temporary files so your working directory doesn't become cluttered.