# SQL Project - Data Cleaning and Data Extraction

## Table of Contents
- [Overview](#overview)
- [Project Goals](#project-goals)
- [Dataset](#dataset)
- [Techniques and Methods](#techniques-and-methods)
- [Steps and Process](#steps-and-process)
  - [1. Data Cleaning](#1-data-cleaning)
  - [2. Data Extraction and Analysis](#2-data-extraction-and-analysis)
- [Skills Utilized and Gained](#skills-utilized-and-gained)
- [Acknowledgements](#acknowledgements)
- [How to Use](#how-to-use)

----------------------------------------------------------------------

## Overview
This project showcases my journey in learning SQL through data cleaning and analysis of layoffs data. The goal was to develop a comprehensive skill set in SQL by handling real-world datasets, guided by AlexTheAnalyst's tutorials on YouTube. 

While following the tutorials, I added my personal enhancements, such as deeper use of Common Table Expressions (CTEs), advanced window functions, and more detailed data transformations.

The project is hosted on GitHub: [TasnimHussein911/SQL-Layoffs-Analysis](https://github.com/TasnimHussein911/SQL-Layoffs-Analysis).

## Project Goals
1. Demonstrate SQL data cleaning techniques while preserving raw data.
2. Perform insightful data extraction to analyze trends and draw conclusions.
3. Build a professional portfolio showcasing SQL expertise.

## Dataset
The dataset includes details about layoffs across various companies, such as:
- **Company**: Name of the company.
- **Location**: Where the layoffs occurred.
- **Industry**: Sector of the company.
- **Total Laid Off**: Number of employees affected.
- **Percentage Laid Off**: Percentage of layoffs relative to the company's size.
- **Date**: When the layoffs occurred.
- **Stage**: Business stage of the company (e.g., startup, growth).
- **Country**: The country of operation.
- **Funds Raised**: Financial information about the company.

## Techniques and Methods
1. **Data Cleaning**:
   - Identifying and removing duplicate records.
   - Standardizing inconsistent data entries.
   - Addressing null values effectively.
   - Dropping unnecessary columns for clarity.
2. **Data Analysis**:
   - Discovering trends over time.
   - Examining industry-specific and location-specific patterns.
   - Ranking companies by the magnitude of layoffs.

## Steps and Process

### 1. Data Cleaning
#### Key Steps:
- **Duplicate Removal**:
  Used window functions and Common Table Expressions (CTEs) to identify and remove duplicate records.
  
- **Data Standardization**:
  - Trimmed unnecessary whitespace using the `TRIM` function.
  - Unified inconsistent values, such as variations of "crypto."
  - Standardized dates into `YYYY-MM-DD` format for consistency.
  
- **Null Value Management**:
  - Retained meaningful null values for contextual analysis.
  - Deleted rows where critical data was missing (`total_laid_off` and `percentage_laid_off`).

- **Column Simplification**:
  - Removed unnecessary columns (e.g., `row_num`) after cleaning.

### 2. Data Extraction and Analysis
#### Key Queries:
- **Layoff Trends**:
  - Identified monthly and yearly layoff trends.
  - Calculated rolling totals to observe cumulative effects.

- **Company-Specific Insights**:
  - Ranked companies with the largest layoffs each year.
  - Highlighted companies with 100% layoffs and analyzed their financial background.

- **Industry and Location Analysis**:
  - Summarized layoffs by industry and location to determine the most affected sectors and areas.

## Skills Utilized and Gained
This project allowed me to develop:
- **SQL Proficiency**:
  - Advanced querying using CTEs and window functions.
  - Effective handling of duplicates, null values, and data transformations.
  - Expertise in date-time operations.
- **Problem Solving**:
  - Systematic approach to cleaning and analyzing messy data.
  - Ability to derive meaningful insights from datasets.
- **Project Structuring**:
  - Organized workflows for data cleaning and analysis.
  - Documented processes for clear understanding.

## Acknowledgements
Special thanks to **AlexTheAnalyst** for his beginner-friendly tutorials, which provided the foundation for this project. I expanded upon the tutorials with additional research and customizations to demonstrate my understanding of SQL.

## How to Use
1. Clone the repository:
   ```bash
   git clone https://github.com/TasnimHussein911/SQL-Layoffs-Analysis.git
   ```
2. Import the dataset into your SQL environment.
3. Run the SQL scripts step by step to replicate the cleaning and analysis process.
4. Explore additional insights by modifying the queries.
