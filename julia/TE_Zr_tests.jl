# tests for TE partitioning and Zircons saturation calculations



using MAGEMin_C
# First we provide a bulk
TE_db       = get_TE_database("TE_OL_felsic")
components  = ["SiO2","TiO2","Al2O3","O","FeO","MnO","MgO","CaO","K2O","Na2O","H2O","Li","Be","B","Sc","V","Cr","Ni","Cu","Zn","Rb","Sr","Y","Zr","Nb","Cs","Ba","La","Ce","Pr","Nd","Sm","Eu","Gd","Tb","Dy","Ho","Er","Tm","Yb","Lu","Hf","Ta","Pb","Th","U"]
Ton	        = [69.20111492,0.385480479,15.36802994,0.08,2.835169639,0.052720082,1.173738821,3.375444597,1.767078881,4.503466421,2,0.,0.,0.,5.524762752,39.87762745,49.26129576,15.04133712,15.15293785,63.74940359,64.5373756,484.5753262,7.459369222,150.2402264,5.430265866,2.474580356,499.0093971,29.06202556,53.78324684,5.797620808,20.54095673,3.317738791,0.961548784,2.418869313,0.315058021,1.593968618,0.296925128,0.799927928,0.128677572,0.713354049,0.133287066,3.95645511,0.722386615,15.17205921,5.69152854,1.064824497]
Bas         = [50.60777553,0.953497243,13.70435413,0.19,11.28130762,0.202560796,8.496024312,9.502380068,0.700881685,2.07434927,4,29.14258603,0.434482763,29.69200003,38.23663423,257.4346716,529.333066,208.2057375,88.87615683,91.7592182,16.60777308,163.4533209,20.74016207,66.90677472,3.808354064,1.529226981,122.8449739,6.938172601,16.04827796,2.253943183,10.18276823,3.3471043,0.915941652,3.28230146,1.417695298,3.851230952,0.914966282,2.20425,0.343734976,2.136202593,0.323405135,1.841502082,0.330971265,5.452969044,1.074692058,0.290233271]

C0_TE_idx   = [findfirst(isequal(x), components) for x in TE_db.element_name]


C0_TE       = Ton[C0_TE_idx]

# Then we call MAGENin
db          = "mp"
sys_in      = "wt"    
data        = Initialize_MAGEMin(db, verbose=false);

P,T         = 2.0, 750.0
Xoxides     = ["SiO2","TiO2","Al2O3","O","FeO","MgO","CaO","K2O","Na2O","H2O"];
X           = [69.20111492,0.385480479,15.36802994,0.08,2.835169639,1.173738821,3.375444597,1.767078881,4.503466421,2];


out, out_te     = single_point_minimization(    P, T, data, X=X, Xoxides=Xoxides, sys_in=sys_in,
                                                tepm    = 1,
                                                te_db   = "OL",
                                                zr_sat  = "CB",
                                                te_X    = C0_TE )




