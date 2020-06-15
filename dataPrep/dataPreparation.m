function [comsolFullData, indexes, elPot, potentialsDatabase] = dataPreparation(pathToFiles, mp) 

cmslData = allElectrodeDataImport(mp.elecFirst, mp.elecLast, pathToFiles);
comsolFullData = cmslData;

idxd = electrodeIndexer(dataCropper(cmslData, mp), mp);
indexes = idxd;

ep = electrodePotentials(idxd, mp);
elPot = ep;

potentialsDatabase =  adjLeadVoltageCalc(elPot);
end