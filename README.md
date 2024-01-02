# Azure Monitor Alerts

Implementation for Azure Monitor Alerts

<img src=".assets/monitor-alerts.png" />

Create the infrastructure:

```sh
cp config/sample.tfvars .auto.tfvars
```

Create the infrastructure:

```sh
terraform init
terraform apply -auto-approve
```

Upload blobs to trigger the alarm:

```sh
az storage blob upload \
    --account-name <storage-account> \
    --container-name blobs \
    --name test.txt \
    --file test.txt \
    --auth-mode login
```

## Management Lock alerts

One option is to create an alert when a **lock** is created.

To achieve that, select the desired scope, and in the Alert Rule, select the **Signal** named **`Add management locks (Management lock)`**.

Alerts can also be sent to sent via push notification to the **Azure mobile app** in the Action Group by identifying the user account email.

```sh
az monitor action-group create --name ContosoWebhookAction \
    --resource-group ContosoVMRG \
    --action azureapppush test_apppush bob@contoso.com
```
