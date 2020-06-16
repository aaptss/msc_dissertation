imdl= mk_common_model('j2d4c',32); 
fmdl= imdl.fwd_model;
stim = mk_stim_patterns(8,1,[0,1],[1,0],{},1);
imdl.fwd_model.stimulation = stim;

% Identify block in centre
ctrs= interp_mesh(fmdl);
xe= ctrs(:,1); ye= ctrs(:,2);
re= (xe).^2+(ye-0.5).^2<0.2^2';
block=(re<.69); % for 1024

sim_img= mk_image(fmdl,1);
v_homg= fwd_solve(sim_img);

sim_img.elem_data(block) = 1.1;
v_simu= fwd_solve(sim_img);

clf;
calc_colours('greylev',-.1); % white background
show_fem(sim_img)
print -r50 -dpng total_variation01a.png;
figure

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Total Variation hereunder 
% Create TV Inverse Model
invtv= eidors_obj('inv_model', 'EIT inverse');
invtv.reconst_type= 'difference';
invtv.jacobian_bkgnd.value= 1;

invtv.hyperparameter.value = .03;
invtv.solve=       @inv_solve_TV_pdipm;
invtv.R_prior=     @prior_TV;
invtv.parameters.term_tolerance= 1e-3;
invtv.parameters.keep_iterations= 1;

invtv.fwd_model= fmdl;
   
invtv.parameters.max_iterations= 20;
imgtv= inv_solve( invtv, v_homg, v_simu);

clf;
show_slices(imgtv)
print -r100 -dpng total_variation04a.png;
figure

