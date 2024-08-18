# GBFS Data Processing and Analytics Project

## Introduction

This project provides a scalable and observable infrastructure to monitor and analyze bike-sharing data from various GBFS providers. It includes advanced analytics to calculate trends over time and compare vehicle availability across different regions, with the capability to visualize this data using AWS QuickSight.

## Architecture Overview

The infrastructure is built using AWS services, orchestrated with Terraform. Key components include:

- **AWS Lambda**: Processes GBFS data and calculates vehicle trends.
- **AWS S3**: Stores raw and processed data.
- **AWS SNS**: Sends alerts based on data thresholds.
- **AWS CloudWatch**: Monitors the system and triggers alarms.
- **AWS Glue and Athena**: Catalogs and queries data for analysis.
- **AWS QuickSight**: Visualizes the data.

## Instructions to Build and Run

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/RichieTheDev/gbfs.git
   cd gbfs
   ```
2. ```bash
   cd terraform
   terraform init
   terraform apply
   ```

## CI/CD Pipeline

The CI/CD pipeline for this project is set up using GitHub Actions. The pipeline performs the following steps:

1. **Checkout Code**: Pulls the latest code from the repository.
2. **Set Up Terraform**: Initializes and applies Terraform configurations.
3. **Deploy Lambda Function**: Packages and deploys the Lambda function for processing GBFS data.
4. **Upload Athena Query**: Uploads the SQL query to the designated S3 bucket.
5. **Deploy QuickSight Dataset**: Creates and configures the QuickSight dataset for visualizing trends.
6. **Notify Success**: Sends an email notification upon successful deployment.

### Pipeline Setup

To enable the CI/CD pipeline:

1. Ensure GitHub Actions is enabled for your repository.
2. Create the required secrets in the GitHub repository:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `SMTP_USERNAME`
   - `SMTP_PASSWORD`
3. Push changes to the `main` branch to trigger the pipeline.

## Things I Would Change If I Had More Time

1. **Enhance Predictive Analytics**:

   - Implement machine learning models to predict future vehicle availability based on historical data and trends. This would allow for more accurate forecasting and better resource allocation.

2. **Expand Region Comparisons**:

   - Include additional regions to provide a more comprehensive analysis of vehicle availability trends across different geographical areas. This could involve integrating more GBFS providers and normalizing data for effective comparison.

3. **Automate QuickSight Setup**:
   - Automate the setup and configuration of QuickSight dashboards using the AWS SDK. This would streamline the process of creating visualizations and ensure consistency across different environments.

4. Properly test the github actions.

## Final Thoughts

The infrastructure and code provided in this project deliver a robust, scalable solution for processing and analyzing GBFS data. If I had more time, I would enhance the predictive analytics by incorporating machine learning models and improve the automation of the QuickSight setup.

This project is a solid foundation for further development, and it can be easily expanded to include additional data sources and analytics capabilities.
