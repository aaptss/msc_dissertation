dir% 3D Model
imdl= mk_common_model('f3cr',32);
imdl.stimuation = fmdl.stimulation;
imdl.fwd_model = fmdl;
imdl.record_data = comsolEleData;

   imdl.R_prior = @prior_tikhonov;
   
%%
   imdl.RtR_prior = calc_RtR_prior(imdl);
   imdl.solve= @inv_solve_cg;
   imdl.reconst_type= 'absolute';
   imdl.inv_solve.max_iterations= 15;
   imdl.hyperparameter.value = 1e-1;
   imdl.inv_solve.term_tolerance = 1e-3;

show_fem(imdl.fwd_model);
%%
 
 img=inv_solve(imdl,vi); % ***
 show_fem(img,1);