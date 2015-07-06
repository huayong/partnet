
function flds = cell_struct_field(cellarr, field_name)

flds = zeros(size(cellarr));

for i=1:size(cellarr,1)
    for j=1:size(cellarr,2)
        flds(i,j) = getfield(cellarr{i,j}, field_name);
    end
end

end