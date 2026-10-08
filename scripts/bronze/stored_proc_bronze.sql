CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    BEGIN TRY

        DECLARE @start_time DATETIME, @end_time DATETIME;
        DECLARE @total_start_time DATETIME, @total_end_time DATETIME;

        SET @total_start_time = GETDATE();

        PRINT 'THE LOADING OF THE TABLES';
        PRINT '--------------------------------------------';
        PRINT 'BEFORE THAT THE TABLES ARE BEING TRUNCATED';
        PRINT '--------------------------------------------';

        TRUNCATE TABLE bronze.crm_cust_info;
        TRUNCATE TABLE bronze.CUST_AZ12;
        TRUNCATE TABLE bronze.LOC_A101;
        TRUNCATE TABLE bronze.PX_CAT_G1V2;
        TRUNCATE TABLE bronze.[bronze.crm.prd_info];
        TRUNCATE TABLE bronze.sales_details;

        PRINT 'TABLES TRUNCATED SUCCESSFULLY';
        PRINT '--------------------------------------------';

        SET @start_time = GETDATE();

        PRINT 'Loading bronze.crm_cust_info';

        BULK INSERT bronze.crm_cust_info
        FROM 'D:\KAUSHAL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            CODEPAGE = '65001',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT 'bronze.crm_cust_info LOADED SUCCESSFULLY';
        PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
        PRINT '--------------------------------------------';


        SET @start_time = GETDATE();

        PRINT 'Loading bronze.CUST_AZ12';

        BULK INSERT bronze.CUST_AZ12
        FROM 'D:\KAUSHAL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            CODEPAGE = '65001',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT 'bronze.CUST_AZ12 LOADED SUCCESSFULLY';
        PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
        PRINT '--------------------------------------------';


        SET @start_time = GETDATE();

        PRINT 'Loading bronze.LOC_A101';

        BULK INSERT bronze.LOC_A101
        FROM 'D:\KAUSHAL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            CODEPAGE = '65001',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT 'bronze.LOC_A101 LOADED SUCCESSFULLY';
        PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
        PRINT '--------------------------------------------';


        SET @start_time = GETDATE();

        PRINT 'Loading bronze.PX_CAT_G1V2';

        BULK INSERT bronze.PX_CAT_G1V2
        FROM 'D:\KAUSHAL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            CODEPAGE = '65001',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT 'bronze.PX_CAT_G1V2 LOADED SUCCESSFULLY';
        PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
        PRINT '--------------------------------------------';


        SET @start_time = GETDATE();

        PRINT 'Loading bronze.[bronze.crm.prd_info]';

        BULK INSERT bronze.[bronze.crm.prd_info]
        FROM 'D:\KAUSHAL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            CODEPAGE = '65001',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT 'bronze.[bronze.crm.prd_info] LOADED SUCCESSFULLY';
        PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
        PRINT '--------------------------------------------';


        SET @start_time = GETDATE();

        PRINT 'Loading bronze.sales_details';

        BULK INSERT bronze.sales_details
        FROM 'D:\KAUSHAL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            CODEPAGE = '65001',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT 'bronze.sales_details LOADED SUCCESSFULLY';
        PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
        PRINT '--------------------------------------------';


        SET @total_end_time = GETDATE();

        PRINT 'ALL BRONZE TABLES LOADED SUCCESSFULLY';
        PRINT '--------------------------------------------';
        PRINT '>> TOTAL LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @total_start_time, @total_end_time) AS VARCHAR) + ' seconds';

    END TRY

    BEGIN CATCH

        PRINT 'ERROR OCCURRED DURING BRONZE DATA LOADING';
        PRINT '--------------------------------------------';
        PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE();
        PRINT 'ERROR NUMBER: ' + CAST(ERROR_NUMBER() AS VARCHAR);
        PRINT 'ERROR LINE: ' + CAST(ERROR_LINE() AS VARCHAR);

    END CATCH
END;
GO
