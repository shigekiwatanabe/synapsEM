function coated_fpits_size_data = average_coated_fpits_diameter (data, analysis_type)

a=0;
b=0;
c=0;

% row 1-5 is for coated_fpits in active zone
% row 6-10 is for coated_fpits in no active zone
% row 11-15 is for coated_fpits in the ternminal (total)

% row 1,6,11  = neck_width
% row 2,7,12  = height
% row 3,8,13  = diameter (FWHM)
% row 4,9,14  = perimeter
% row 5,10,15 = 3D surface area
if strcmp(analysis_type, 'total')
    
    for i = 1:length(data)
        
        if isfield(data(i).analysis_data, 'coated_coated_fpits')
            
            a = a+1;
            
            b = b+length(data(i).analysis_data.coated_coated_fpits);
            
        end
    end
    
elseif strcmp(analysis_type, 'az')
    
    b=c;
    
    for i = 1:length(data)
      
        if isfield(data(i).analysis_data, 'coated_coated_fpits')
           
            for j = 1:length(data(i).distance_data.coated_coated_fpits)
                
                if data(i).distance_data.coated_coated_fpits(j).in_az == 1
            
                    b = b+1;
                    
                end
            end
            
            if b > c
                
                a = a+1;
                
            end
            
            c = b;
        end
    end
    
elseif strcmp(analysis_type, 'non_az')
    
    b=c;
    
    for i = 1:length(data)

        if isfield(data(i).analysis_data, 'coated_coated_fpits')
           
            for j = 1:length(data(i).distance_data.coated_coated_fpits)
                
                if data(i).distance_data.coated_coated_fpits(j).in_az == 0
            
                    b = b+1;
                    
                end
            end
            
            if b > c
                
                a = a+1;
            end
            
            c = b;
        end
    end
end
           
coated_fpits_size_data.average_total = zeros(5,b+5);
coated_fpits_size_data.average_profile = zeros(5,a+5);

if strcmp (analysis_type, 'total')
    % for all coated_fpits
    m=6;
    n=6;
    for i = 1:length(data)
        
        if isfield(data(i).analysis_data, 'coated_fpits')
            
            for j = 1:length(data(i).analysis_data.coated_fpits)
                
                coated_fpits_size_data.average_total(1,m) = data(i).analysis_data.coated_fpits(j).neck_width;
                coated_fpits_size_data.average_total(2,m) = data(i).analysis_data.coated_fpits(j).height;
                coated_fpits_size_data.average_total(3,m) = data(i).analysis_data.coated_fpits(j).diameter;
                coated_fpits_size_data.average_total(4,m) = data(i).analysis_data.coated_fpits(j).length;
                coated_fpits_size_data.average_total(5,m) = data(i).analysis_data.coated_fpits(j).surface_area;
                
                m=m+1;
            end
            
            coated_fpits_size_data.average_profile (1,n) = mean(coated_fpits_size_data.average_total(1,((m-1)-j):(m-1)));
            coated_fpits_size_data.average_profile (2,n) = mean(coated_fpits_size_data.average_total(2,((m-1)-j):(m-1)));
            coated_fpits_size_data.average_profile (3,n) = mean(coated_fpits_size_data.average_total(3,((m-1)-j):(m-1)));
            coated_fpits_size_data.average_profile (4,n) = mean(coated_fpits_size_data.average_total(4,((m-1)-j):(m-1)));
            coated_fpits_size_data.average_profile (5,n) = mean(coated_fpits_size_data.average_total(5,((m-1)-j):(m-1)));
            
            n=n+1;
            
        end
    end
    
    % for only the coated_fpits in active zone
elseif strcmp (analysis_type, 'az')
    m=6;
    n=6;
    g=0;
    h=0;
    
    for i = 1:length(data)
        
        h=g;
        
        if isfield(data(i).analysis_data, 'coated_fpits')
            
            for j = 1:length(data(i).analysis_data.coated_fpits)
                
                if data(i).distance_data.coated_fpits(j).in_az == 1
                    
                    coated_fpits_size_data.average_total(1,m) = data(i).analysis_data.coated_fpits(j).neck_width;
                    coated_fpits_size_data.average_total(2,m) = data(i).analysis_data.coated_fpits(j).height;
                    coated_fpits_size_data.average_total(3,m) = data(i).analysis_data.coated_fpits(j).diameter;
                    coated_fpits_size_data.average_total(4,m) = data(i).analysis_data.coated_fpits(j).length;
                    coated_fpits_size_data.average_total(5,m) = data(i).analysis_data.coated_fpits(j).surface_area;
                    
                    m=m+1;
                    h=h+1;
                end
            end
            
            if h > g
                
                coated_fpits_size_data.average_profile (1,n) = mean(coated_fpits_size_data.average_total(1,(m-h):(m-1)));
                coated_fpits_size_data.average_profile (2,n) = mean(coated_fpits_size_data.average_total(2,(m-h):(m-1)));
                coated_fpits_size_data.average_profile (3,n) = mean(coated_fpits_size_data.average_total(3,(m-h):(m-1)));
                coated_fpits_size_data.average_profile (4,n) = mean(coated_fpits_size_data.average_total(4,(m-h):(m-1)));
                coated_fpits_size_data.average_profile (5,n) = mean(coated_fpits_size_data.average_total(5,(m-h):(m-1)));
                
                n=n+1;
                
            end
            
            g = h;
            
        end
    end
    
    % for only the coated_fpits in non-active zone
elseif strcmp (analysis_type, 'non_az')
    
    m=6;
    n=6;
    g=0;
    h=0;
    
    for i = 1:length(data)
        
        h=g;
        
        if isfield(data(i).analysis_data, 'coated_fpits')
            
            for j = 1:length(data(i).analysis_data.coated_fpits)
                
                if data(i).distance_data.coated_fpits(j).in_az == 0
                    
                    coated_fpits_size_data.average_total(1,m) = data(i).analysis_data.coated_fpits(j).neck_width;
                    coated_fpits_size_data.average_total(2,m) = data(i).analysis_data.coated_fpits(j).height;
                    coated_fpits_size_data.average_total(3,m) = data(i).analysis_data.coated_fpits(j).diameter;
                    coated_fpits_size_data.average_total(4,m) = data(i).analysis_data.coated_fpits(j).length;
                    coated_fpits_size_data.average_total(5,m) = data(i).analysis_data.coated_fpits(j).surface_area;
                    
                    m=m+1;
                    h=h+1;
                end
            end
            
            if h > g
                
                coated_fpits_size_data.average_profile (1,n) = mean(coated_fpits_size_data.average_total(1,(m-h):(m-1)));
                coated_fpits_size_data.average_profile (2,n) = mean(coated_fpits_size_data.average_total(2,(m-h):(m-1)));
                coated_fpits_size_data.average_profile (3,n) = mean(coated_fpits_size_data.average_total(3,(m-h):(m-1)));
                coated_fpits_size_data.average_profile (4,n) = mean(coated_fpits_size_data.average_total(4,(m-h):(m-1)));
                coated_fpits_size_data.average_profile (5,n) = mean(coated_fpits_size_data.average_total(5,(m-h):(m-1)));
                
                n=n+1;
                
            end
            
            g = h;
            
        end
    end
end

for i = 1:5
    
    coated_fpits_size_data.average_total(i,1) = mean (coated_fpits_size_data.average_total(i,6:b+5));
    coated_fpits_size_data.average_profile(i,1) = mean (coated_fpits_size_data.average_profile(i,6:a+5));
    
end

for i = 1:5
    
    coated_fpits_size_data.average_total(i,2) = median (coated_fpits_size_data.average_total(i,6:b+5));
    coated_fpits_size_data.average_profile(i,2) = median (coated_fpits_size_data.average_profile(i,6:a+5));
    
end

for i = 1:5
    
    coated_fpits_size_data.average_total(i,3) = std (coated_fpits_size_data.average_total(i,6:b+5));
    coated_fpits_size_data.average_profile(i,3) = std (coated_fpits_size_data.average_profile(i,6:a+5));
    
end

for i = 1:5
    
    coated_fpits_size_data.average_total(i,4) = (coated_fpits_size_data.average_total(i,3))/sqrt(b);
    coated_fpits_size_data.average_profile(i,4) = (coated_fpits_size_data.average_profile(i,3))/sqrt(a);
    
end

for i = 1:5
    
    coated_fpits_size_data.average_total(i,5) = (coated_fpits_size_data.average_total(i,1)...
                                      -  coated_fpits_size_data.average_total(i,2))...
                                      /  coated_fpits_size_data.average_total(i,3);
    coated_fpits_size_data.average_profile(i,5) = (coated_fpits_size_data.average_profile(i,1)...
                                        -  coated_fpits_size_data.average_profile(i,2))...
                                        /  coated_fpits_size_data.average_profile(i,3);
    
end
        

end