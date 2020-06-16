mdl = mk_common_model('j2d4c', 16);

img_1 = mk_image(mdl);
h1= subplot(221);
show_fem(img_1);

img_2 = img_1;
select_fcn = inline('(x).^2+(y-0.5).^2<0.1^2','x','y','z');
img_2.elem_data = 1 + elem_select(img_2.fwd_model, select_fcn);

h2= subplot(222);
show_fem(img_2);

img_2.calc_colours.cb_shrink_move = [.3,.8,-0.02];
common_colourbar([h1,h2],img_2);

print_convert forward_solvers01a.png
%%%%%%

% Calculate a stimulation pattern
stim = mk_stim_patterns(16,1,[0,8],[0,1],{},1);

% Solve all voltage patterns
img_2.fwd_model.stimul
ation = stim;
img_2.fwd_solve.get_all_meas = 1;
vh = fwd_solve(img_2);

% Show first stim pattern
%h1= subplot(221);
img_v = rmfield(img_2, 'elem_data');
img_v.node_data = vh.volt(:,1);
show_fem(img_v);

