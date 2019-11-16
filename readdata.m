% Script to read and unzip data files

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Unzipping the Developed 25 Portfolios and saving them in the current folder
url1 = 'https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/Developed_25_Portfolios_ME_Prior_12_2_CSV.zip';
unzip(url1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Reading the Developed 25 Portfolios and extracting the relevant information
% up until August 2008

% Average Value Weighted Returns -- Monthly
AVWR = readmatrix('Developed_25_Portfolios_ME_Prior_12_2.csv', 'Range', 'A14:Z227');

%  Average Equal Weighted Returns -- Monthly
AEWR = readmatrix('Developed_25_Portfolios_ME_Prior_12_2.csv', 'Range', 'A366:Z579');

% Number of Firms in Portfolios
NoF = readmatrix('Developed_25_Portfolios_ME_Prior_12_2.csv', 'Range', 'A784:Z997');

% Average Firm Size

AFS = readmatrix('Developed_25_Portfolios_ME_Prior_12_2.csv', 'Range', 'A1136:Z1349');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Reading the data again "out of sample", so from September 2008 until the
% most recent obervation (Note: since the Global Factors dataset only goes
% until January 2016, the data after that has been omitted)

% Average Value Weighted Returns -- Monthly
AVWR2 = readmatrix('Developed_25_Portfolios_ME_Prior_12_2.csv', 'Range', 'A228:Z316');

%  Average Equal Weighted Returns -- Monthly
AEWR2 = readmatrix('Developed_25_Portfolios_ME_Prior_12_2.csv', 'Range', 'A577:Z665');

% Number of Firms in Portfolios
NoF2 = readmatrix('Developed_25_Portfolios_ME_Prior_12_2.csv', 'Range', 'A992:Z1080');

% Average Firm Size

AFS2 = readmatrix('Developed_25_Portfolios_ME_Prior_12_2.csv', 'Range', 'A1341:Z1429');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Unzipping the Global Factors and saving them in the current folder
url2 = 'https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/Developed_3_Factors_CSV.zip';
unzip(url2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Reading the Global Factors and extracting the relevant information
% up until August 2008 (Note: the dataset technically starts in July 1990, but
% since the other dataset starts in November 1990, we are only reading the
% data from then onwards)

GFactors = readmatrix('Developed_3_Factors.csv', 'Range', 'A12:E225');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Reading the data again "out of sample", so from September 2008 until the
% most recent obervation

GFactors2 = readmatrix('Developed_3_Factors.csv', 'Range', 'A226:E314');

