# This script helps to generate a lsit of points for testing MAGEMin using reference built-in bulk-rock compositions

cd("../")       # change to main directory

using MAGEMin_C

gv, DB = init_MAGEMin();

mutable struct outP{ _T  } 
    P           ::  _T
    T           ::  _T 
    test        ::  Int64

    G           ::  _T
    ph          ::  Vector{String}
    ph_frac     ::  Vector{Float64}
end

outList       = Vector{outP}(undef, 0)

# test 0
test        = 1
gv.verbose  = -1    # switch off any verbose

Tmin        = 800.0
Tmax        = 2000.0
Tstep       = 200.0
Pmin        = 0.0
Pmax        = 50.0
Pstep       = 10.0

for i=Pmin:Pstep:Pmax
    for j=Tmin:Tstep:Tmax

        bulk_rock   = get_bulk_rock(gv, test)
        out         = point_wise_minimization(i,j, bulk_rock, gv, DB)
    
        push!(outList,outP(i,j,test,out.G_system,out.ph,out.ph_frac[:]))
        print(out)
    end
end


print(outList)
print(size(outList))
