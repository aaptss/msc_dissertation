clear modelParams
mp = mPara32(1,32);

baseFolder= "D:\OneDrive\bmstu\!! Master's thesis\00 04 Thesis\EIT_MSc_aaptss\data\";
cmslHomo = strcat(baseFolder, "data_homogen\");
cmslInhomo=strcat(baseFolder, "data_inhomogen\");

[~,~,~,cmslInhomoDB] = dataPreparation(cmslInhomo, mp);
[~,~,~,cmslHomoDB]   = dataPreparation(cmslHomo,   mp);
%%
fmdl = geomModelPrep(mp);
[fmdl.stimulation, vicomsol] = comsol_eidors_data_api(cmslInhomoDB, mp);
[~,                vhcomsol] = comsol_eidors_data_api(cmslHomoDB,   mp);
vhcomsol.meas(30:end) = -vhcomsol.meas(30:end);
% for i = modelParams.elecFirst : modelParams.elecLast
%     fmdl.electrode(i).z_contact = modelParams.elecHei / (pi * modelParams.elecRad^2 * modelParams.sigma.agagcl);
% end
%% solve for homogen   
    imgh = mk_image(fmdl,1);
    vh = fwd_solve(imgh);
%% solve for inhomogen
    imgi = imgh;
%     imgi.elem_data(fmdl.mat_idx{1})= mp.sigma.softT; % soft tissue
    imgi.elem_data(fmdl.mat_idx{2})= mp.sigma.heart; % heart
    imgi.elem_data(fmdl.mat_idx{3})= mp.sigma.lung; % llung
    imgi.elem_data(fmdl.mat_idx{4})= mp.sigma.lung; % rlung

    vi = fwd_solve(imgi);
%% 
clear imdl cmslimgcmsl cmslimgeido eidoimgcmsl eidoimgeido
opt.imgsz = [32 32];
opt.distr = 3; % non-random, uniform
opt.Nsim = 1000;
opt.target_size = 0.05; % Target size (frac of medium)
opt.noise_figure = 0.5; % Recommended NF=0.5;
% opt.target_plane = mp.beltH;

imdl= mk_GREIT_model(imgi, 0.1, [], opt);

% imdl.reconst_type = 'static';
imdl.reconst_type= 'difference';
% imdl.reconst_type= 'absolute';
imdl.R_prior = @prior_tikhonov;
imdl.RtR_prior = @laplace_image_prior;
% imdl.solve= @inv_solve_cg;
% imdl.solve= @inv_solve_trunc_iterative;
imdl.inv_solve.max_iterations= 50;
imdl.hyperparameter.value = 1e-2;
imdl.inv_solve.term_tolerance = 1e-1;

cmslimgcmsl = inv_solve(imdl,vhcomsol, vicomsol);
cmslimgeido = inv_solve(imdl,vhcomsol, vi);
eidoimgcmsl = inv_solve(imdl,vh, vicomsol);
eidoimgeido = inv_solve(imdl,vh, vi);

% 
% cmslimgcmsl = inv_solve(imdl,vhcomsol.meas, vicomsol.meas);
% cmslimgeido = inv_solve(imdl,vhcomsol.meas, vi.meas);
% eidoimgcmsl = inv_solve(imdl,vh.meas, vicomsol.meas);
% eidoimgeido = inv_solve(imdl,vh.meas, vi.meas);
%%
show_fem(cmslimgcmsl)
title('comsol - comsol');
figure
show_fem(cmslimgeido)
title('comsol - eidors');
figure
show_fem(eidoimgcmsl)
title('eidors - comsol');
figure
show_fem(eidoimgeido)
title('eidors - eidors');