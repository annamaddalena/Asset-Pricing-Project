% Script to read and unzip data files

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Unzipping the Global 6 Portfolios and saving them in the current folder
url1 = 'https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/Global_6_Portfolios_ME_Prior_12_2_CSV.zip';
unzip(url1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Reading the Global 6 Portfolios and extracting the relevant information
% up until August 2008

% Average Value Weighted Returns -- Monthly
AVWR = readmatrix('Global_6_Portfolios_ME_Prior_12_2.csv', 'Range', 'A14:G227');

%  Average Equal Weighted Returns -- Monthly
AEWR = readmatrix('Global_6_Portfolios_ME_Prior_12_2.csv', 'Range', 'A363:G576');

% Number of Firms in Portfolios
NoF = readmatrix('Global_6_Portfolios_ME_Prior_12_2.csv', 'Range', 'A778:G991');

% Average Firm Size

AFS = readmatrix('Global_6_Portfolios_ME_Prior_12_2.csv', 'Range', 'A1127:G1340');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Reading the data again "out of sample", so from September 2008 until the
% most recent obervation (Note: since the Global Factors dataset only goes
% until January 2016, the data after that has been omitted)

% Average Value Weighted Returns -- Monthly
AVWR2 = readmatrix('Global_6_Portfolios_ME_Prior_12_2.csv', 'Range', 'A228:G316');

%  Average Equal Weighted Returns -- Monthly
AEWR2 = readmatrix('Global_6_Portfolios_ME_Prior_12_2.csv', 'Range', 'A577:G665');

% Number of Firms in Portfolios
NoF2 = readmatrix('Global_6_Portfolios_ME_Prior_12_2.csv', 'Range', 'A992:G1080');

% Average Firm Size

AFS2 = readmatrix('Global_6_Portfolios_ME_Prior_12_2.csv', 'Range', 'A1341:G1429');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Unzipping the Global Factors and saving them in the current folder
url2 = 'https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/Global_Factors_CSV.zip';
unzip(url2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Reading the Global Factors and extracting the relevant information
% up until August 2008 (Note: the dataset technically starts in July 1990, but
% since the other dataset starts in November 1990, we are only reading the
% data from then onwards)

GFactors = readmatrix('Global_Factors.csv', 'Range', 'A12:F225');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Reading the data again "out of sample", so from September 2008 until the
% most recent obervation

GFactors2 = readmatrix('Global_Factors.csv', 'Range', 'A226:F314');

