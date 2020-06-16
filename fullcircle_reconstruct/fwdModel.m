geomModel;
fmdl= ng_mk_cyl_models([mParam.norm.thorH,...
                        [mParam.norm.thorR,...
                        0.1]],...
                          [mParam.elecLast,mParam.norm.beltH + mParam.norm.thorH/2],...
                            [mParam.norm.elecR],extra); 
show_fem(fmdl); 
xlabel('x')
zlabel('z')
[fmdl.stimulation,~] = mk_stim_patterns(32,1,[0,1],[0,1],{'no_meas_current'}, 1*mParam.iAmp); 
%% homogen 
imgh = mk_image(fmdl,1);show_fem(imgh);
vh = fwd_solve(imgh);
%% inhomogen
imgi = imgh;
imgi.elem_data(fmdl.mat_idx{2})= mParam.sigma.heart; % heart
imgi.elem_data(fmdl.mat_idx{3})= mParam.sigma.lung; % llung
imgi.elem_data(fmdl.mat_idx{4})= mParam.sigma.lung; % rlung
clf; show_fem(imgh); view(0,70);
vi = fwd_solve(imgi);
% figure
%%
% xax= 1:length(vh.meas);
% hh= plotyy(xax,[vh.meas, vi.meas], ...
%            xax, vh.meas- vi.meas );
% 
% set(hh,'Xlim',[1,max(xax)]);