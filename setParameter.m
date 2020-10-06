function st=setParameter(st,name,value)

for idx=1:size(st,1)
    if(strcmp(st(idx).Name,name))
        st(idx).Value=value;
        break;
    end
end
