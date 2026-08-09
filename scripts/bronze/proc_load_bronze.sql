/*
===============================================================================
Stored Procedure: bronze.load_bronze
===============================================================================
Script Purpose:
    This stored procedure loads raw data from the CRM and ERP source CSV files
    into the Bronze layer tables of the DataWarehouse database.

    The Bronze layer stores the source data in its original or near-original
    form before any major cleaning or transformation is performed.

    The procedure performs the following actions:
        - Truncates each Bronze table before loading new data.
        - Loads data from the CRM CSV files using BULK INSERT.
        - Loads data from the ERP CSV files using BULK INSERT.
        - Tracks the loading duration for each individual table.
        - Tracks the total execution time for the entire Bronze load.
        - Prints progress messages during execution.
        - Uses TRY...CATCH error handling to display useful error information
          if the loading process fails.

    CRM Source Files:
        - cust_info.csv
        - prd_info.csv
        - sales_details.csv

    ERP Source Files:
        - CUST_AZ12.csv
        - LOC_A101.csv
        - PX_CAT_G1V2.csv

Usage:
    Execute the stored procedure using:

        EXEC bronze.load_bronze;

WARNING:
    This procedure uses TRUNCATE TABLE before each BULK INSERT.
    Therefore, all existing data in the Bronze tables will be removed
    and replaced with the latest data from the source CSV files.

===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN

    DECLARE @start_time DATETIME,
            @end_time DATETIME,
            @batch_start_time DATETIME,
            @batch_end_time DATETIME;

    BEGIN TRY

        SET @batch_start_time = GETDATE();

        PRINT '=========================';
        PRINT 'Loading Bronze Layer';
        PRINT '=========================';

        PRINT '----------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '----------------------------';


        -- ============================================
        -- CRM CUSTOMER INFO
        -- ============================================

        SET @start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.crm_cust_info';

        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> Inserting Data Into: bronze.crm_cust_info';

        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\labib\Desktop\Data Analyst\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
            + ' seconds';

        PRINT '----------------------';


        -- ============================================
        -- CRM PRODUCT INFO
        -- ============================================

        SET @start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.crm_prd_info';

        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>> Inserting Data Into: bronze.crm_prd_info';

        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\labib\Desktop\Data Analyst\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
            + ' seconds';

        PRINT '----------------------';


        -- ============================================
        -- CRM SALES DETAILS
        -- ============================================

        SET @start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.crm_sales_details';

        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> Inserting Data Into: bronze.crm_sales_details';

        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\labib\Desktop\Data Analyst\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
            + ' seconds';

        PRINT '----------------------';


        PRINT '----------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '----------------------------';


        -- ============================================
        -- ERP CUSTOMER
        -- ============================================

        SET @start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.erp_cust_az12';

        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT '>> Inserting Data Into: bronze.erp_cust_az12';

        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\labib\Desktop\Data Analyst\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
            + ' seconds';

        PRINT '----------------------';


        -- ============================================
        -- ERP LOCATION
        -- ============================================

        SET @start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.erp_loc_a101';

        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT '>> Inserting Data Into: bronze.erp_loc_a101';

        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\labib\Desktop\Data Analyst\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
            + ' seconds';

        PRINT '----------------------';


        -- ============================================
        -- ERP PRODUCT CATEGORY
        -- ============================================

        SET @start_time = GETDATE();

        PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';

        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';

        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\labib\Desktop\Data Analyst\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> Load Duration: '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20))
            + ' seconds';

        PRINT '----------------------';


        -- ============================================
        -- TOTAL BRONZE LOAD TIME
        -- ============================================

        SET @batch_end_time = GETDATE();

        PRINT '=========================';
        PRINT 'Bronze Layer Loaded Successfully';

        PRINT '>> Total Load Duration: '
            + CAST(
                DATEDIFF(
                    SECOND,
                    @batch_start_time,
                    @batch_end_time
                ) AS NVARCHAR(20)
              )
            + ' seconds';

        PRINT '=========================';

    END TRY


    BEGIN CATCH

        PRINT '===========================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';

        PRINT 'Error Message: '
            + ERROR_MESSAGE();

        PRINT 'Error Number: '
            + CAST(ERROR_NUMBER() AS NVARCHAR(20));

        PRINT 'Error State: '
            + CAST(ERROR_STATE() AS NVARCHAR(20));

        PRINT 'Error Line: '
            + CAST(ERROR_LINE() AS NVARCHAR(20));

        PRINT '===========================================';

    END CATCH;

END;
GO
