m=301
w1=[0 (0.0136*pi) (0.0907*pi) (0.0181*pi) (0.5442*pi)]
w2=[(0.0136*pi) (0.0907*pi) (0.1814*pi) (0.5442*pi) pi]
n=[-((m-1)/2) : ((m-1)/2)]

[y p]=size(w1);
[y q]=size(w2);
for (i=1:1:p && l=1:1:q)
hrect(1,:) = ((w2(1,:)/pi)*sin((w2(1,:)*n)/pi))-((w1(1,:)/pi)*sin((w1(1,:)*n)/pi))
stem(n,hrect)
title('rectangular window')

w= window(@bartlett,m)
hbart(1,:)=hrect(1,:).*w';
figure;
stem(n,hbart(1,:))
title('bartlett window');
end
