function [P1_xx,P1_xy,P1_xo,P2_xx,P2_xy,P2_xo,PE1_xx,PE1_xy,PE1_xo,PE2_xx,PE2_xy,PE2_xo]= predictive_coding_local_global(n, SP, s0, s1, s2);

% Input:
% n: number of tones in a squence
% SP: [SPxx, SPxy, SPxo] e.q. [4/6 1/6 1/6]

% Output:
% P1_xx= P1 in xx sequence

%% Check 
if sum(SP) ~=1
     disp('The sum of SP should be 1.')   
     return
end

%% TP and SP
SPxx= SP(1);
SPxy= SP(2);

TNx=(n-1)*SPxx+(n-2)*SPxy+(n-2)*(1-SPxx-SPxy);
TNy=SPxy;
TPx=TNx/(TNx+1);
TPy=TNy/(TNx+1);


%% P1 and P2
% P1
P1x=s0^(n-1)*TPx; 
P1y=TPy;
                
% s1 modulation
P1x=P1x*s1; 
P1y=P1y*s1; 

P1_xx=P1x+P1y;
P1_xy=P1x+P1y;
P1_xo=P1x+P1y;

               
% P2
P2x=SPxx*(abs(s0^(n-1)-P1x))+(1-SPxx)*P1x;
P2y=SPxy*(abs(1-P1y))+(1-SPxy)*P1y;
                
% s2 modulation
P2x=P2x*s2; 
P2y=P2y*s2; 

P2_xx=P2x+P2y;
P2_xy=P2x+P2y;
P2_xo=P2x+P2y;

%% PE1 and PE2

S=[s0^(n-1) 0 0 1 0 0];  %xx xy xo  

%PE1
PE1= abs(S - [P1x P1y P1x P1y P1x P1y]);

PE1_xx=PE1(1)+PE1(2);
PE1_xy=PE1(3)+PE1(4);
PE1_xo=PE1(5)+PE1(6);


%PE2
PE2= abs(PE1 - [P2x P2y P2x P2y P2x P2y]);

PE2_xx=PE2(1)+PE2(2);
PE2_xy=PE2(3)+PE2(4);
PE2_xo=PE2(5)+PE2(6);
