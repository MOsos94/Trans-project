close all
clear all
clc

Nin = 3;
Nout = 7;
User_sensitivity = 10^(-120/10);
C_I = 3;
A_user = 1/144;
Total_Area = 450;
Pb = 0.005;
Pt_in = 1;
Pt_out = 2;
k = 2;
Ctotal = 100;
lambda = (3*10^8)/(1.8*10^9);
%flag = 0;
%for Nin = [1 3 4 7 9 12 13]
%    for Nout = [1 3 4 7 9 12 13]
        for i = 1:Ctotal
            flag = 0;
            Cin = i;
            Cout = Ctotal - Cin;
            Cin_Nin = floor(Cin/Nin);
            Cout_Nout = floor(Cout/Nout);
            if (Cin_Nin == 0) || (Cout_Nout == 0)
                %break
                Cin_Nin = 1;
                Cout_Nout = 1;
            end
            Ain = findrhob(Cin_Nin,Pb);
            Aout = findrhob(Cout_Nout,Pb);
            Rin = sqrt((Ain)/(k*A_user*pi));
            Rout = sqrt((2/(3*sqrt(3)))*((Aout/(k*A_user))+(pi*Rin^2)));
            Psens_in = Pt_in*(lambda/(4*pi*Rin))^2;
            Psens_out = Pt_out*(lambda/(4*pi*Rout))^2;
            C_Iout = (3*Nout)/6;
            C_Iin = (3*(Rout^2)*Nin)/(6*Rin^2);
            if (Psens_in >= User_sensitivity) && (Psens_out >= User_sensitivity) && (C_I <= C_Iout) && (C_I <= C_Iin)
                flag = 1;
                break
            end
        end
%         if flag == 1
%             break
%         end
%     end
%     if flag == 1
%         break
%     end
% end
Number_Of_Wireless_Cells = (Total_Area*10^6)/((3.3/2)*Rout^2)
Diameter_Of_Inner_Cells = 2*Rin
Diameter_Of_Outer_Cells = 2*Rout
Numer_Of_Channels_Assigned_to_Inner_Cells = Cin
Numer_Of_Channels_Assigned_to_Outer_Cells = Cout
Reuse_Factor_Inner_Cells = Nin
Reuse_Factor_Outer_Cells = Nout


