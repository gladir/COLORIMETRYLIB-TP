{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2023
  @website(https://www.gladir.com/CODER/COLORIMETRYLIB-TP)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}

Unit COLORFNC;

INTERFACE

Procedure CMYK2RGB(C,M,Y,K:Real;Var R,G,B:Byte);
Procedure GreyRGB(Var R,G,B:Byte);
Procedure HSI2RGB(Var H,S,I:Real;Var R,G,B:Byte);
Procedure HSL2RGB(H,S,L:Real;Var R1,G1,B1:Byte);
Procedure HSV2RGB(H,S,V:Real;Var R1,G1,B1:Byte);
Procedure NegRGB(Var R,G,B:Byte);
Procedure RGB2CMYK(R,G,B:Byte;Var C1,M1,Y1,K1:Byte);
Procedure RGB2HSL(R,G,B:Byte;Var H,S,L:Real);
Procedure RGB2HSV(R,G,B:Byte;Var H,S,V:Real);
Function  RGB2HTML(R,G,B:Byte):String;
Procedure RGB2XYZ(R,G,B:Byte;Var X,Y,Z:Real);
Procedure RGB2YIQ(R,G,B:Byte;Var Y,I,Q:Real);
Procedure RGB2YUV(R,G,B:Byte;Var Y,U,V:Real);
Procedure XYZ2RGB(X,Y,Z:Real;Var R,G,B:Byte);
Procedure YIQ2RGB(Y,I,Q:Real;Var R,G,B:Byte);

IMPLEMENTATION

Function Max(A,B,C:Real):Real;
Var
 T:Real;
Begin
 T:=0;
 If A>T Then T:=A;
 If B>T Then T:=B;
 If C>T Then T:=C;
 Max:=T;
End;

Function Min(A,B,C:Real):Real;
Var
 T:Real;
Begin
 T:=A;
 If A<T Then T:=A;
 If B<T Then T:=B;
 If C<T Then T:=C;
 Min:=T;
End;

Function ByteHex2Str(value:Byte):String;
Const
 matrix:Array[0..15]of Char = ('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F');
Begin
 ByteHex2Str:=matrix[(value shr 4) and $0F]+matrix[value and $F];
End;


Procedure CMYK2RGB(C,M,Y,K:Real;Var R,G,B:Byte);
Var
 tk:Real;
Begin
  tk:=(255-K)/255;
  R:=Byte(Round(C*tk+K));
  G:=Byte(Round(Y*tk+K));
  B:=Byte(Round(M*tk+K));
End;

Procedure GreyRGB(Var R,G,B:Byte);
Var
 Moy:Byte;
Begin
 Moy:=(R+G+B) div 3;
End;

Procedure HSI2RGB(Var H,S,I:Real;Var R,G,B:Byte);
Var
 R1,G1,B1,T:Real;
Begin
 T:=H;
 R1:=1+S*Sin(t-2*pi/3);
 G1:=1+S*Sin(t);
 B1:=1+S*Sin(t+2*pi/3);
 T:=255.999*i/2;
 B:=Byte(Trunc(B1*T));
 G:=Byte(Trunc(G1*T));
 R:=Byte(Trunc(R1*T));
End;

Procedure HSL2RGB(H,S,L:Real;Var R1,G1,B1:Byte);
Var
 M,X,HH,C,F,T,R,G,B:Real;
Begin
 If H<0 Then H:=0;
 If S<0 Then S:=0;
 If L<0 Then L:=0;
 If H>=360 Then H:=359;
 If S>100 Then S:=100;
 If L>100 Then L:=100;
 S:=S/100;
 L:=L/100;
 C:=(1-Abs(2*l-1))*S;
 hh:=h/60;
 X:=C*(1-abs((Trunc(hh) mod 2)-1));
 R:=0;
 G:=0;
 B:=0;
 If((hh >= 0) and (hh<1))Then Begin
  R:=C;
  G:=X;
 End
  Else
 If((hh>=1)and(hh<2))Then Begin
  R:=X;
  G:=C;
 End
  Else
 If((hh>=2)and(hh<3))Then Begin
  G:=C;
  B:=X;
 End
  Else
 If((hh>=3) and (hh<4))Then Begin
  G:=X;
  B:=C;
 End
  Else
 If((hh>=4)and(hh<5))Then Begin
  R:=X;
  B:=C;
 End
  Else
 Begin
  R:=C;
  B:=X;
 End;
 M:=L-C/2;
 R:=R+M;
 G:=G+M;
 B:=B+M;
 R1:=Trunc(R*255);
 G1:=Trunc(G*255);
 B1:=Trunc(B*255);
End;

Procedure HSV2RGB(H,S,V:Real;Var R1,G1,B1:Byte);
Var
 Zone:Byte;
 R,G,B,F,T:Real;
Begin
 If H=360Then H:=0;
 Zone:=Trunc(H/60);
 F:=H/60-Zone;
 Case(Zone)of
  0:Begin
   r:=v;
   g:=v*(1-s*(1-f));
   b:=v*(1-s);
  End;
  1:Begin
   r:=v*(1-s*f);
   g:=v;
   b:=v*(1-s);
  End;
  2:Begin
   r:=v*(1-s);
   g:=v;
   b:=v*(1-s*(1-f));
  End;
  3:Begin
   r:=v*(1-s);
   g:=v*(1-s*f);
   b:=v;
  End;
  4:Begin
   r:=v*(1-s*(1-f));
   g:=v*(1-s);
   b:=v;
  End;
  5:Begin
   r:=v;
   g:=v*(1-s);
   b:=v*(1-s*f);
  End;
  Else Begin
   R:=0;G:=0;B:=0;
  End;
 End;
 R1:=Trunc(R*256);
 G1:=Trunc(G*256);
 B1:=Trunc(B*256);
End;

Procedure NegRGB(Var R,G,B:Byte);Begin
 R:=255-R;
 G:=255-G;
 B:=255-B;
End;

Procedure RGB2CMYK(R,G,B:Byte;Var C1,M1,Y1,K1:Byte);
Var
 R1,G1,B1,C,M,Y,K:Real;
Begin
 R1:=R/255.0;
 G1:=G/255.0;
 B1:=B/255.0;
 K:=1-Max(R1,G1,B1);
 C:=(1-R1);
 If 1-K<>0Then C:=C/(1-K);
 M:=(1-G1);
 If 1-K<>0Then M:=M/(1-K);
 Y:=(1-B1);
 If 1-K<>0Then Y:=Y/(1-K);
 C1:=Trunc(C*100);
 M1:=Trunc(M*100);
 Y1:=Trunc(Y*100);
 K1:=Trunc(K*100);
End;

Procedure RGB2HSL(R,G,B:Byte;Var H,S,L:Real);
Var
 R1,G1,B1,Cmax,Cmin,Delta:Real;
Begin
 R1:=R/255;
 G1:=G/255;
 B1:=B/255;
 Cmax:=Max(r1, g1, b1);
 Cmin:=Min(r1, g1, b1);
 L:=(Cmax+Cmin)/2;
 If Cmax = Cmin Then Begin
  H:=0;
  S:=0;
 End
  Else
 Begin
  Delta := Cmax - Cmin;
  If L<0.5 Then S:=Delta/(Cmax+Cmin)
           Else S:=Delta/(2-Cmax-Cmin);
  If R1=Cmax Then H:=(g1-b1)/Delta Else
  If G1=Cmax Then H:=2+(B1-R1)/Delta
             Else H:=4+(R1-G1)/Delta;
  H:=H/6;
  If H<0 Then H:=H+1
 End;
End;

Procedure RGB2HSV(R,G,B:Byte;Var H,S,V:Real);
Var
 R1,G1,B1,m:Real;
Begin
 R1:=R/256;
 G1:=G/256;
 B1:=B/256;
 If(R1>G1)Then Begin
  If(R1>B1)Then v:=R1
           Else v:=B1;
  If(G1<B1)Then m:=G1
           Else m:=B1;
 End
  Else
 Begin
  If(G1>B1)Then v:=G1
           Else v:=B1;
  If(R1<B1)Then m:=R1
           Else m:=B1
 End;
  {En fait V:=Max(r,g,b) M:=Min(r,g,b)}
 If V<>0Then S:=(V-M)/V
        Else S:=0;      {Calcul saturation}
 If S<>0Then Begin      {Calcul de l'angle}
  If(V=R1)Then If(M=G1)Then H:=5+(V-B1)/(V-M)
                       Else H:=1-(V-G1)/(V-M)
  Else If(V=G1)Then If(M=B1)Then H:=1+(v-R1)/(V-M)
                            Else H:=3-(v-B1)/(V-M)
  Else If(V=B1)Then If(M=R1)Then H:=3+(v-G1)/(V-M)
                            Else H:=5-(v-R1)/(V-M);
  H:=H*60;
  If H=360Then H:=0;
 End
  Else
 Begin
   {Noir}
  H:=0;
  S:=0;
 End;
End;

Function RGB2HTML(R,G,B:Byte):String;Begin
 RGB2HTML:='#'+ByteHex2Str(R)+ByteHex2Str(G)+ByteHex2Str(B);
End;

Procedure RGB2XYZ(R,G,B:Byte;Var X,Y,Z:Real);
Var
 R1,G1,B1:Real;
Begin
 R1:=0.0039215*R; { 0..1 }
 G1:=0.0039215*G; { 0..1 }
 B1:=0.0039215*B; { 0..1 }
 X:=0.431*R1+0.342*G1+0.178*B1;
 Y:=0.222*R1+0.707*G1+0.071*B1;
 Z:=0.020*R1+0.130*G1+0.939*B1;
End;

Procedure RGB2YIQ(R,G,B:Byte;Var Y,I,Q:Real);Begin
 Y:=((0.299*R)+(0.587*G)+(0.114*B))/256;
 I:=((0.596*R)-(0.274*G)-(0.322*B))/256;
 Q:=((0.212*R)-(0.523*G)+(0.311*B))/256;
End;

Procedure RGB2YUV(R,G,B:Byte;Var Y,U,V:Real);Begin
 Y:=Trunc(0.3*R+0.59*G+0.11*G);
 U:=Trunc((B-Y)*0.493);
 V:=Trunc((R-Y)*0.877);
End;

Procedure XYZ2RGB(X,Y,Z:Real;Var R,G,B:Byte);Begin
 R:=Byte(Trunc((3.063*X-1.393*Y-0.476*Z)*255));
 G:=Byte(Trunc((-0.969*X+1.876*Y+0.042*Z)*255));
 B:=Byte(Trunc((0.068*X-0.229*Y+1.069*Z)*255));
End;

Procedure YIQ2RGB(Y,I,Q:Real;Var R,G,B:Byte);
Var
 R1,G1,B1:Real;
Begin
 R1:=(Y+(0.956*I)+(0.621*Q));
 G1:=(Y-(0.272*I)-(0.647*Q));
 B1:=(Y-(1.105*I)+(1.702*Q));
 R:=Byte(Trunc(R1*256));
 G:=Byte(Trunc(G1*256));
 B:=Byte(Trunc(B1*256));
End;

END.