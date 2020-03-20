function out = RESIZEBL(filename,scale)
    im = imread(filename,'jpg');
    scale_factor = scale;
    sz = size(im)
    final_sz = sz*scale_factor
    final_sz(3) = 3
    S_R = sz(1) / final_sz(1);
    S_C = sz(2) / final_sz(2);
    [cf, rf] = meshgrid(1 : final_sz(2), 1 : final_sz(1));
    rf = rf * S_R;r = floor(rf);
    cf = cf * S_C;c = floor(cf);
    r(r < 1) = 1; c(c < 1) = 1;
    r(r > sz(1) - 1) = sz(1) - 1; c(c > sz(2) - 1) = sz(2) - 1;
    dr = rf - r;
    dc = cf - c;
    in1 = sub2ind([sz(1), sz(2)], r, c);
    in2 = sub2ind([sz(1), sz(2)], r+1,c);
    in3 = sub2ind([sz(1), sz(2)], r, c+1);
    in4 = sub2ind([sz(1), sz(2)], r+1, c+1);
    out = zeros(final_sz(1), final_sz(2), size(im, 3));
    out = cast(out, class(im));
    for idx = 1 : size(im, 3)
        channel = double(im(:,:,idx));
        tmp = channel(in1).*(1 - dr).*(1 - dc) + channel(in2).*(dr).*(1 - dc) + channel(in3).*(1 - dr).*(dc) +channel(in4).*(dr).*(dc);
        out(:,:,idx) = cast(tmp, class(im));
    end
end
