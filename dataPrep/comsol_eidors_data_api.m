function [eit_stim, eit_dta] = comsol_eidors_data_api(cmslData, mp)
cnt = 1;
eit_dta.meas = zeros(928,1);
eit_dta.time = NaN;
eit_dta.name = 'from COMSOL';
eit_dta.type = 'data';
    for i = mp.elecFirst : mp.elecLast
        eit_stim(i).stimulation = mp.iVal; %#ok<AGROW>
        
        iConf = zeros(mp.elecLast,1);
        vConf = zeros(mp.elecLast - 3, mp.elecLast);  

        for j = mp.elecFirst : mp.elecLast
            iConf(cmslData(i).iPos,1) = mp.iAmp;
            iConf(cmslData(i).iNeg,1) = - mp.iAmp;
            eit_stim(i).stim_pattern = sparse(iConf);
        end
        k = 0;
        for j = mp.elecFirst : mp.elecLast
            if ~isempty(cmslData(i).Leads(j).Voltage)
                k = k+1;
                vConf(k, cmslData(i).Leads(j).vPos) = 1;
                vConf(k, cmslData(i).Leads(j).vNeg) = -1;
                eit_dta.meas(cnt) = cmslData(i).Leads(j).Voltage;
                cnt = cnt + 1;
            end
        end
        eit_stim(i).meas_pattern = sparse(vConf);
    end
end