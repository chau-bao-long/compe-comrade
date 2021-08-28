if exists('g:loaded_compe_comrade')
  finish
endif

let g:loaded_compe_comrade = v:true

if exists('g:loaded_compe')
  lua require'compe'.register_source('comrade', require'compe_comrade')
endif
