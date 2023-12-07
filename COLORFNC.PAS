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

END.