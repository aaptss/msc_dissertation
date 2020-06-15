function pots = adjLeadVoltageCalc(pots)
% function calculates lead voltages for every pair of adjacent 
% electrodes possible
% for a current pair 

for i = 1 : numel(pots)
    for j = 1 : numel(pots(i).Potentials)
        if j == numel(pots(i).Potentials)
            k = 1;
        else
            k = j + 1;
        end
        pots(i).Leads(j).iPos = pots(i).iPos;
        pots(i).Leads(j).iNeg = pots(i).iNeg;
        pots(i).Leads(j).vPos = j;
        pots(i).Leads(j).vNeg = k;
        
        if ~((pots(i).Leads(j).vPos == pots(i).iPos) || (pots(i).Leads(j).vPos == pots(i).iNeg) || ...
             (pots(i).Leads(j).vNeg == pots(i).iPos) || (pots(i).Leads(j).vNeg == pots(i).iNeg))
            
            pots(i).Leads(j).Voltage= pots(i).Potentials(j).VoltV - pots(i).Potentials(k).VoltV;
        end
    end
end
