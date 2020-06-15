function pots = electrodePotentials(idxed,mp)
% electrodePotentials returns struct variable with full data: what is potential
% for any given electrode with every given current pair
z = 0;
    for i = mp.elecFirst : mp.elecLast
        for j = mp.elecFirst : mp.elecLast
            z = z + 1;
            pots(z).iPos = i;
            pots(z).iNeg = j;
            for k = mp.elecFirst : mp.elecLast
                if ~isempty(idxed{i,j})
                    pots(z).Potentials(k).iPos = i;
                    pots(z).Potentials(k).iNeg = j;
                    pots(z).Potentials(k).eleID = k;
                    pots(z).Potentials(k).VoltV = mean(idxed{i,j}.V(idxed{i,j}.index == k, :)); %mean value of potentials from rawData in place on electrode k
                end
            end
        end % j = modelParameters.elecFirst : modelParameters.elecLast
    end % i = modelParameters.elecFirst : modelParameters.elecLast
z = 0;
    for i = mp.elecFirst : mp.elecLast
        for j = mp.elecFirst : mp.elecLast
            z = z + 1;
            if isempty(pots(z).Potentials)
                pots(z) = [];
                z = z-1;
            end
        end % j = modelParameters.elecFirst : modelParameters.elecLast
    end % i = modelParameters.elecFirst : modelParameters.elecLast
end
