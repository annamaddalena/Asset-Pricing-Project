% Subtracting the risk free rate from all the portfolio returns: 
% Average Value Weighted Portfoio Returns - Risk Free Return

ExcessAVWR = AVWR(1:end, 2:end) - GFactors(1:end, 5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Estimate alpha and beta for 5 years at a time over a rolling one month basis 
% by running a time series regression

alpha = zeros((length(AVWR)-60), 25);
beta = zeros((length(AVWR)-60), 25);
epsilon = zeros((length(AVWR)-60)*60, 25);

for k = 1:(length(AVWR)-60)          % 60 = 5*12 to get 5 year windows, incrementing monthly in each iteration

X = [ones(60, 1), GFactors(k:(60+k-1), 2)];     % Excess Market Returns (for periods of 5 years)
alphabeta = zeros(2, 25);

    for i = 1:25            % Running loop for all 25 portfolios

        Y = ExcessAVWR(k:(60+k-1), i);    % Excess Portfolio Returns
        alphabeta(1:end, i) = X\Y;        % Contains alpha and beta for the 5 year period for each portfolio

    end

alpha(k, 1:end) = alphabeta(1, 1:end);
beta(k, 1:end) = alphabeta(2, 1:end);

epsilon(k:(60+k-1), 1:end) = Y - X*alphabeta;


end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Average of betas for each of the 25 portfolios

avgbeta = zeros(1, 25);    % row vector

for j = 1:25
    
    avgbeta(1, j) = mean(beta(1:end, j));
end

% Sorting the betas in ascending order.

[A, B] = sort(avgbeta, 'ascend');

sortedavgbeta = [B; A];     % First row: portfolio, second row: sorted betas

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Corss-sectional regression

gamma0 = zeros(length(AVWR)-60, 1);
gamma1 = zeros(length(AVWR)-60, 1);
mu = zeros(25, length(AVWR)-60);

for m = 1:(length(AVWR)-60)

    W = ExcessAVWR(60 + m, 1:25)';
    Z = [ones(25, 1), beta(m, 1:25)'];

    gamma = Z\W;
    
    gamma0(m) = gamma(1);
    gamma1(m) = gamma(2);

    mu(1:end, m) = W - Z*gamma;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Average of gammas

avggamma0 = mean(gamma0);       % Should be 0 if CAPM is true
avggamma1 = mean(gamma1);       % Should be the excess return on the market if CAPM is true

% Average real excess market returns

avgrealGF = mean(GFactors(61:end, 2));

% Absolute Error between estimated and actual excess market return

errormktrt = abs(avggamma1 - avgrealGF);

% Standard errors of gamma0 and gamma1

stdegamma0 = sqrt(var(gamma0)) * 1/sqrt((length(AVWR)-60));

stdegamma1 = sqrt(var(gamma1)) * 1/sqrt((length(AVWR)-60));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% t-Test for gamma0 and gamma1

tgamma0 = (avggamma0 - 0)/stdegamma0;

tgamma1 = (avggamma1 - avgrealGF)/stdegamma1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Adding additional factors SMB and HML

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Time series regression

a = zeros((length(AVWR)-60), 25);
b = zeros((length(AVWR)-60), 25);
s = zeros((length(AVWR)-60), 25);
h = zeros((length(AVWR)-60), 25);
epsilon2 = zeros((length(AVWR)-60)*60, 25);

for k = 1:(length(AVWR)-60)          % 60 = 5*12 to get 5 year windows, incrementing monthly in each iteration

X2 = [ones(60, 1), GFactors(k:(60+k-1), 2), GFactors(k:(60+k-1), 3), GFactors(k:(60+k-1), 4)];     % Excess Market Returns (for periods of 5 years)
factors = zeros(4, 25);

    for i = 1:25            % Running loop for all 25 portfolios

        Y2 = ExcessAVWR(k:(60+k-1), i);    % Excess Portfolio Returns
        factors(1:end, i) = X2\Y2;        % Contains alpha and beta for the 5 year period for each portfolio

    end

a(k, 1:end) = factors(1, 1:end);
b(k, 1:end) = factors(2, 1:end);
s(k, 1:end) = factors(3, 1:end);
h(k, 1:end) = factors(4, 1:end);

epsilon2(k:(60+k-1), 1:end) = Y2 - X2*factors;


end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Corss-sectional regression

phi0 = zeros(length(AVWR)-60, 1);
phi1 = zeros(length(AVWR)-60, 1);
phi2 = zeros(length(AVWR)-60, 1);
phi3 = zeros(length(AVWR)-60, 1);
nu = zeros(25, length(AVWR)-60);

for m = 1:(length(AVWR)-60)

    W2 = ExcessAVWR(60 + m, 1:25)';
    Z2 = [ones(25, 1), b(m, 1:25)', s(m, 1:25)', h(m, 1:25)'];

    phi = Z2\W2;
    
    phi0(m) = phi(1);
    phi1(m) = phi(2);
    phi2(m) = phi(3);
    phi3(m) = phi(4);
    

    nu(1:end, m) = W2 - Z2*phi;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Averages of factors

avgphi0 = mean(phi0);       % Should be 0
avgphi1 = mean(phi1);       % Should be excess market return
avgphi2 = mean(phi2);       % Should be expected return of SMB
avgphi3 = mean(phi3);       % Should be expected return of HML

% Average of real SMB and HML portfolios

avgrealsmb = mean(GFactors(61:end, 3));
avgrealhml = mean(GFactors(61:end, 4));

% Standard errors of phi0, phi1, phi2 and phi3

stdephi0 = sqrt(var(phi0)) * 1/sqrt((length(AVWR)-60));
stdephi1 = sqrt(var(phi1)) * 1/sqrt((length(AVWR)-60));
stdephi2 = sqrt(var(phi2)) * 1/sqrt((length(AVWR)-60));
stdephi3 = sqrt(var(phi3)) * 1/sqrt((length(AVWR)-60));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% t-Test for phi0, phi1, phi2 & phi3

tphi0 = (avgphi0 - 0)/stdephi0;
tphi1 = (avgphi1 - avgrealGF)/stdephi1;
tphi2 = (avgphi2 - avgrealsmb)/stdephi2;
tphi3 = (avgphi3 - avgrealhml)/stdephi3;



