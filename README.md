
# Azure Infrastructure as Code with Bicep

## 📦 Overview

This repository contains Infrastructure as Code (IaC) definitions written in **Bicep** for provisioning a complete set of Azure resources required to deploy a web application. The deployment includes:

- **Azure Web App**
- **Azure SQL Server**
- **Azure SQL Database**
- **Azure Storage Account**
- **Azure Virtual Network (VNet)**
- **Azure Virtual WAN**

These resources are designed to be deployed efficiently using modular and parameterized Bicep templates.

---

## 🛠️ Design Choices

### 1. **Bicep Templates**
Bicep was chosen over traditional ARM templates for its improved readability, maintainability, and modularity. It simplifies complex resource definitions while maintaining compatibility with ARM.

### 2. **Parameterization**
Templates use parameters such as:
- `location`
- `sqlServerName`
- `sqlDatabaseName`

This makes the solution **reusable** and **flexible** across different environments and deployments.

### 3. **Dynamic Resource Naming**
Resource names are generated dynamically using expressions and functions to ensure uniqueness during deployments.

### 4. **Location Inference**
Resources inherit the deployment location via the `location` parameter to maintain consistency.

### 5. **Security**
Sensitive data such as passwords are marked using the `@secure()` directive to ensure encryption at deployment.

### 6. **Code Comments**
Inline comments are included in Bicep files to help you understand usage, customization points, and deployment strategies.

---

## 📋 Specific Considerations

### 🔗 Dependencies
Resource dependencies (e.g., SQL Database depends on SQL Server) are managed using implicit or explicit `dependsOn`.

### ⚠️ Error Handling
While Bicep has limited built-in error handling, template validation and clear error messages have been emphasized for easier debugging.

### 🧭 Resource Scope
Templates respect resource scopes. No resource intended for a resource group is deployed at the subscription level.

### ✅ Validation
Templates were tested and validated using:
- **Bicep CLI** for syntax and linting
- **Azure sandbox environments** for end-to-end provisioning

---

## 🚀 Deployment Instructions

### 📌 Prerequisites
- Azure CLI installed and logged in
- Azure subscription and resource group created
- Bicep CLI (integrated in Azure CLI)

### 🧪 Deploy from CLI
```bash
az deployment group create \
  --name webAppDeployment \
  --resource-group <your-resource-group> \
  --template-file main.bicep \
  --parameters sqlServerName=<your-sql-server-name> sqlDatabaseName=<your-db-name>
```

---

## 🧯 Troubleshooting

If deployment issues occur, check:
- Azure CLI or portal error messages
- Parameter values (e.g., unique resource names)
- Quota limits or region availability
- Azure Bicep documentation: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/

You may also consult:
- [Microsoft Q&A](https://learn.microsoft.com/en-us/answers/)
- [Azure Forums](https://techcommunity.microsoft.com/t5/azure/ct-p/Azure)

---

## 📂 Project Structure

```
azure-bicep-iac/
├── main.bicep
├── README.md
└── parameters.json (optional)
```

---

## 📌 Status

✅ Actively maintained and tested  
📅 Last updated: 2025/08/02

---

## 📃 License
This project is open-sourced under the MIT License.
