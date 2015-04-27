program Project1;

uses
  Forms,
  Windows,
  main in 'main.pas' {Form1},
  IntervalArithmetic32and64 in 'IntervalArithmetic32and64.pas',
  SplineVal in 'SplineVal.pas' {SplineValForm},
  SplineIntervalVal in 'SplineIntervalVal.pas' {SplineIntervalValForm},
  SplineCoeffs in 'SplineCoeffs.pas' {SplineCoeffsForm},
  SplineCoeffsInterval in 'SplineCoeffsInterval.pas' {SplineCoeffsIntervalForm};

{$R *.res}

begin
  CreateMutex(nil, FALSE, 'spline value');
   if GetLastError() <> 0 then Halt;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TSplineValForm, SplineValForm);
  Application.CreateForm(TSplineIntervalValForm, SplineIntervalValForm);
  Application.CreateForm(TSplineCoeffsForm, SplineCoeffsForm);
  Application.CreateForm(TSplineCoeffsIntervalForm, SplineCoeffsIntervalForm);
  Application.Run;
end.
