%% myImgCompression: Zeilenweise Bildkompression
function [R] = myImgCompression(img, compr, imgout)	
	if nargin==2
		imgout=img
	end
	compress=compr/100
	B=imread(img);
	s=size(B);
	%Fall von 2D Matrizen/SW-Bildern wird abgedeckt
	if size(s)=2
		colors=1
	else
		colors=s(3)
	end
	for c=1:1:colors
		for y=1:1:s(1)
			transformed=fft(double(B(y,:,c)));
			[sor,ind]=sort(abs(transformed));
			for x=1:round(length(ind)*compress)
				transformed(ind(x))=0;
			end
			zuncompr=real(ifft(transformed));
			B(y,:,c)=zuncompr;
		end
	end
	imwrite(B,imgout)
end
for index=10:10:90
	myImgCompression("zebra.bmp",index,[sprintf("zebracomp%.3d.jpg", index)])
end
