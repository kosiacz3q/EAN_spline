library dll;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  StrUtils,
  IntervalArithmetic32and64 in 'IntervalArithmetic32and64.pas';

{$R *.res}

function naturalsplinevalue (n      : Integer;
                             x,f    : array of Extended;
                             xx     : Extended;
                             var st : Integer) : Extended;
{---------------------------------------------------------------------------}
{                                                                           }
{  The function naturalsplinevalue calculates the value of the natural      }
{  cubic spline interpolant for a function given by its values at nodes.    }
{  Data:                                                                    }
{    n  - number of interpolation nodes minus 1 (the nodes are numbered     }
{         from 0 to n),                                                     }
{    x  - an array containing the values of nodes,                          }
{    f  - an array containing the values of function,                       }
{    xx - the point at which the value of interpolating spline should       }
{         be calculated.                                                    }
{  Result:                                                                  }
{    naturalsplinevalue(n,x,f,xx,st) - the value of natural spline at xx.   }
{  Other parameters:                                                        }
{    st - a variable which within the function naturalsplinevalue is        }
{         assigned the value of:                                            }
{           1, if n<1,                                                      }
{           2, if there exist x[i] and x[j] (i<>j; i,j=0,1,...,n) such      }
{              that x[i]=x[j],                                              }
{           3, if xx<x[0] or xx>x[n],                                       }
{           0, otherwise.                                                   }
{         Note: If st<>0, then naturalsplinevalue(n,x,f,xx,st) is not       }
{               calculated.                                                 }
{  Unlocal identifiers:                                                     }
{    vector  - a type identifier of extended array [q0..qn], where q0<=0    }
{              and qn>=n,                                                   }
{    vector1 - a type identifier of extended array [q1..qn2], where q1<=1   }
{              and qn2>=n-2,                                                }
{    vector2 - a type identifier of extended array [q2..qn1], where q2<=2   }
{              and qn1>=n-1.                                                }
{                                                                           }
{---------------------------------------------------------------------------}
var i,k   : Integer;
    u,y,z : Extended;
    found : Boolean;
    a     : array [0..3] of Extended;
    d     : array of Extended;
    b     : array of Extended;
    c     : array of Extended;
begin

    SetLength(b, n + 1 + 0 + 10);
    SetLength(d, n + 2 - 2 + 10);
    SetLength(c, n + 3 - 1 + 10);

    if n<1
    then st:=1
    else if (xx<x[0]) or (xx>x[n])
           then st:=3
           else begin
                  st:=0;
                  i:=-1;
                  repeat
                    i:=i+1;
                    for k:=i+1 to n do
                      if x[i]=x[k]
                        then st:=2
                  until (i=n-1) or (st=2)
                end;
  if st=0
    then begin
             d[0]:=0;
           d[n]:=0;
           if n>1
             then begin
                    z:=x[2];
                    y:=z-x[1];
                    z:=z-x[0];
                    u:=f[1];
                    b[1]:=y/z;
                    d[1]:=6*((f[2]-u)/y-(u-f[0])/(x[1]-x[0]))/z;
                    z:=x[n-2];
                    y:=x[n-1]-z;
                    z:=x[n]-z;
                    u:=f[n-1];
                    c[n-1]:=y/z;
                    d[n-1]:=6*((f[n]-u)/(x[n]-x[n-1])-(u-f[n-2])/y)/z;
                    for i:=2 to n-2 do
                      begin
                        z:=x[i];
                        y:=x[i+1]-z;
                        z:=z-x[i-1];
                        u:=f[i];
                        b[i]:=y/(y+z);
                        c[i]:=1-b[i];
                        d[i]:=6*((f[i+1]-u)/y-(u-f[i-1])/z)/(y+z)
                      end;
                    u:=2;
                    i:=0;
                    y:=d[1]/u;
                    d[1]:=y;
                    if n>2
                      then repeat
                             i:=i+1;
                             z:=b[i]/u;
                             b[i]:=z;
                             u:=2-z*c[i+1];
                             y:=(d[i+1]-y*c[i+1])/u;
                             d[i+1]:=y
                           until i=n-2
                  end;

           u:=d[n-1];
           for i:=n-2 downto 1 do
             begin
               u:=d[i]-u*b[i];
               d[i]:=u
             end;
           found:=False;
           i:=-1;
           repeat
             i:=i+1;
             if (xx>=x[i]) and (xx<=x[i+1])
               then found:=True
           until found;
           y:=x[i+1]-x[i];
           z:=d[i+1];
           u:=d[i];
           a[0]:=f[i];
           a[1]:=(f[i+1]-f[i])/y-(2*u+z)*y/6;
           a[2]:=u/2;
           a[3]:=(z-u)/(6*y);
           y:=a[3];
           z:=xx-x[i];
           for i:=2 downto 0 do
             y:=y*z+a[i];
           naturalsplinevalue:=y
         end;
end;

function naturalsplinevalueInterval (n      : Integer;
                             x,f    : array of interval;
                             xx     : interval;
                             var st : Integer) : interval;
{---------------------------------------------------------------------------}
{                           INTERVAL EQUIVALENT                             }
{---------------------------------------------------------------------------}
var i,k   : Integer;
    u,y,z : interval;
    found : Boolean;
    a     : array [0..3] of interval;
    d     : array of interval;
    b     : array of interval;
    c     : array of interval;
begin

    SetLength(b, n + 1 + 0 + 10);
    SetLength(d, n + 2 - 2 + 10);
    SetLength(c, n + 3 - 1 + 10);

    if n<1
    then st:=1
    else if (xx<x[0]) or (xx>x[n])
           then st:=3
           else begin
                  st:=0;
                  i:=-1;
                  repeat
                    i:=i+1;
                    for k:=i+1 to n do
                      if x[i]=x[k]
                        then st:=2
                  until (i=n-1) or (st=2)
                end;
  if st=0
    then begin
           d[0]:=0;
           d[n]:=0;
           if n>1
             then begin
                    z:=x[2];
                    y:=z-x[1];
                    z:=z-x[0];
                    u:=f[1];
                    b[1]:=y/z;
                    d[1]:=6*((f[2]-u)/y-(u-f[0])/(x[1]-x[0]))/z;
                    z:=x[n-2];
                    y:=x[n-1]-z;
                    z:=x[n]-z;
                    u:=f[n-1];
                    c[n-1]:=y/z;
                    d[n-1]:=6*((f[n]-u)/(x[n]-x[n-1])-(u-f[n-2])/y)/z;
                    for i:=2 to n-2 do
                      begin
                        z:=x[i];
                        y:=x[i+1]-z;
                        z:=z-x[i-1];
                        u:=f[i];
                        b[i]:=y/(y+z);
                        c[i]:=1-b[i];
                        d[i]:=6*((f[i+1]-u)/y-(u-f[i-1])/z)/(y+z)
                      end;
                    u:=2;
                    i:=0;
                    y:=d[1]/u;
                    d[1]:=y;
                    if n>2
                      then repeat
                             i:=i+1;
                             z:=b[i]/u;
                             b[i]:=z;
                             u:=2-z*c[i+1];
                             y:=(d[i+1]-y*c[i+1])/u;
                             d[i+1]:=y
                           until i=n-2
                  end;

           u:=d[n-1];
           for i:=n-2 downto 1 do
             begin
               u:=d[i]-u*b[i];
               d[i]:=u
             end;
           found:=False;
           i:=-1;
           repeat
             i:=i+1;
             if (xx>=x[i]) and (xx<=x[i+1])
               then found:=True
           until found;
           y:=x[i+1]-x[i];
           z:=d[i+1];
           u:=d[i];
           a[0]:=f[i];
           a[1]:=(f[i+1]-f[i])/y-(2*u+z)*y/6;
           a[2]:=u/2;
           a[3]:=(z-u)/(6*y);
           y:=a[3];
           z:=xx-x[i];
           for i:=2 downto 0 do
             y:=y*z+a[i];
           naturalsplinevalueInterval:=y
         end;
end;


type
  TExtendedArray = array of Extended;

procedure naturalsplinecoeffns (n      : Integer;
                                x,f    : array of Extended;
                                var a  : array of TExtendedArray;
                                var st : Integer);
{---------------------------------------------------------------------------}
{                                                                           }
{  The procedure naturalsplinecoeffns calculates the coefficients of the    }
{  natural cubic spline interpolant for a function given by its values at   }
{  nodes.                                                                   }
{  Data:                                                                    }
{    n  - number of interpolation nodes minus 1 (the nodes are numbered     }
{         from 0 to n),                                                     }
{    x  - an array containing the values of nodes,                          }
{    f  - an array containing the values of function.                       }
{  Result:                                                                  }
{    a  - an array of spline coefficients (the element a[k,i] contains the  }
{         coefficient before x^k, where k=0,1,2,3, for the interval         }
{         <x[i], x[i+1]>; i=0,1,...,n-1).                                   }
{  Other parameters:                                                        }
{    st - a variable which within the procedure naturalsplinevalue is       }
{         assigned the value of:                                            }
{           1, if n<1,                                                      }
{           2, if there exist x[i] and x[j] (i<>j; i,j=0,1,...,n) such      }
{              that x[i]=x[j],                                              }
{           0, otherwise.                                                   }
{         Note: If st<>0, then the elements of array a are not calculated.  }
{  Unlocal identifiers:                                                     }
{    vector  - a type identifier of extended array [q0..qn], where q0<=0    }
{              and qn>=n,                                                   }
{    vector1 - a type identifier of extended array [q1..qn2], where q1<=1   }
{              and qn2>=n-2,                                                }
{    vector2 - a type identifier of extended array [q2..qn1], where q2<=2   }
{              and qn1>=n-1,                                                }
{    matrix  - a type identifier of extended array [0..3, q0..qn1], where   }
{              q0<=0 and qn1>=n-1.                                          }
{                                                                           }
{---------------------------------------------------------------------------}
var i,k        : Integer;
    u,v,y,z,xi : Extended;
    d          : array of Extended;
    b          : array of Extended;
    c          : array of Extended;
begin

  SetLength(b, n + 1 + 0 + 10);
  SetLength(d, n + 2 - 2 + 10);
  SetLength(c, n + 3 - 1 + 10);

  if n<1
    then st:=1
    else begin
           st:=0;
           i:=-1;
           repeat
             i:=i+1;
             for k:=i+1 to n do
               if x[i]=x[k]
                 then st:=2
           until (i=n-1) or (st=2)
         end;
  if st=0
    then begin
           d[0]:=0;
           d[n]:=0;
           if n>1
             then begin
                    z:=x[2];
                    y:=z-x[1];
                    z:=z-x[0];
                    u:=f[1];
                    b[1]:=y/z;
                    d[1]:=6*((f[2]-u)/y-(u-f[0])/(x[1]-x[0]))/z;
                    z:=x[n-2];
                    y:=x[n-1]-z;
                    z:=x[n]-z;
                    u:=f[n-1];
                    c[n-1]:=y/z;
                    d[n-1]:=6*((f[n]-u)/(x[n]-x[n-1])-(u-f[n-2])/y)/z;
                    for i:=2 to n-2 do
                      begin
                        z:=x[i];
                        y:=x[i+1]-z;
                        z:=z-x[i-1];
                        u:=f[i];
                        b[i]:=y/(y+z);
                        c[i]:=1-b[i];
                        d[i]:=6*((f[i+1]-u)/y-(u-f[i-1])/z)/(y+z)
                      end;
                    u:=2;
                    i:=0;
                    y:=d[1]/u;
                    d[1]:=y;
                    if n>2
                      then repeat
                             i:=i+1;
                             z:=b[i]/u;
                             b[i]:=z;
                             u:=2-z*c[i+1];
                             y:=(d[i+1]-y*c[i+1])/u;
                             d[i+1]:=y
                           until i=n-2
                  end;
           u:=d[n-1];
           for i:=n-2 downto 1 do
             begin
               u:=d[i]-u*b[i];
               d[i]:=u
             end;
           for i:=0 to n-1 do
             begin
               u:=f[i];
               xi:=x[i];
               z:=x[i+1]-xi;
               y:=d[i];
               v:=(f[i+1]-u)/z-(2*y+d[i+1])*z/6;
               z:=(d[i+1]-y)/(6*z);
               y:=y/2;
               a[0,i]:=((-z*xi+y)*xi-v)*xi+u;
               u:=3*z*xi;

               a[1,i]:=(u-2*y)*xi+v;
               a[2,i]:=y-u;
               a[3,i]:=z
             end
         end
end;

{---------------------------------------------------------------------------}
{                        INTERVAL EQUIVALENT                                }
{---------------------------------------------------------------------------}

type
  TIntervalArray = array of interval;

procedure naturalsplinecoeffnsInterval(n  : Integer;
                                x,f    : array of interval;
                                var a  : array of TIntervalArray;
                                var st : Integer);
var i,k        : Integer;
    u,v,y,z,xi : interval;
    d          : array of interval;
    b          : array of interval;
    c          : array of interval;
begin

  SetLength(b, n + 1 + 0 + 10);
  SetLength(d, n + 2 - 2 + 10);
  SetLength(c, n + 3 - 1 + 10);

  if n<1
    then st:=1
    else begin
           st:=0;
           i:=-1;
           repeat
             i:=i+1;
             for k:=i+1 to n do
               if x[i]=x[k]
                 then st:=2
           until (i=n-1) or (st=2)
         end;
  if st=0
    then begin
           d[0]:=0;
           d[n]:=0;
           if n>1
             then begin
                    z:=x[2];
                    y:=z-x[1];
                    z:=z-x[0];
                    u:=f[1];
                    b[1]:=y/z;
                    d[1]:=6*((f[2]-u)/y-(u-f[0])/(x[1]-x[0]))/z;
                    z:=x[n-2];
                    y:=x[n-1]-z;
                    z:=x[n]-z;
                    u:=f[n-1];
                    c[n-1]:=y/z;
                    d[n-1]:=6*((f[n]-u)/(x[n]-x[n-1])-(u-f[n-2])/y)/z;
                    for i:=2 to n-2 do
                      begin
                        z:=x[i];
                        y:=x[i+1]-z;
                        z:=z-x[i-1];
                        u:=f[i];
                        b[i]:=y/(y+z);
                        c[i]:=1-b[i];
                        d[i]:=6*((f[i+1]-u)/y-(u-f[i-1])/z)/(y+z)
                      end;
                    u:=2;
                    i:=0;
                    y:=d[1]/u;
                    d[1]:=y;
                    if n>2
                      then repeat
                             i:=i+1;
                             z:=b[i]/u;
                             b[i]:=z;
                             u:=2-z*c[i+1];
                             y:=(d[i+1]-y*c[i+1])/u;
                             d[i+1]:=y
                           until i=n-2
                  end;
           u:=d[n-1];
           for i:=n-2 downto 1 do
             begin
               u:=d[i]-u*b[i];
               d[i]:=u
             end;
           for i:=0 to n-1 do
             begin
               u:=f[i];
               xi:=x[i];
               z:=x[i+1]-xi;
               y:=d[i];
               v:=(f[i+1]-u)/z-(2*y+d[i+1])*z/6;
               z:=(d[i+1]-y)/(6*z);
               y:=y/2;
               a[0,i]:=((-z*xi+y)*xi-v)*xi+u;
               u:=3*z*xi;

               a[1,i]:=(u-2*y)*xi+v;
               a[2,i]:=y-u;
               a[3,i]:=z
             end
         end
end;


exports
  naturalsplinevalue,
  naturalsplinevalueInterval,
  naturalsplinecoeffns,
  naturalsplinecoeffnsInterval;

begin
end.
