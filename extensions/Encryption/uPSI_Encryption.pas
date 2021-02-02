unit uPSI_Encryption;
{
This file has been generated by UnitParser v0.7, written by M. Knight
and updated by NP. v/d Spek and George Birbilis.
Source Code from Carlo Kok has been used to implement various sections of
UnitParser. Components of ROPS are used in the construction of UnitParser,
code implementing the class wrapper is taken from Carlo Kok's conv utility

}
interface



uses
   SysUtils
  ,Classes
  ,uPSComponent
  ,uPSRuntime
  ,uPSCompiler
  ;

type
(*----------------------------------------------------------------------------*)
  TPSImport_Encryption = class(TPSPlugin)
  public
    procedure CompileImport1(CompExec: TPSScript); override;
    procedure ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter); override;
  end;


{ compile-time registration functions }
procedure SIRegister_THash(CL: TPSPascalCompiler);
procedure SIRegister_Encryption(CL: TPSPascalCompiler);

{ run-time registration functions }
procedure RIRegister_THash(CL: TPSRuntimeClassImporter);
procedure RIRegister_Encryption(CL: TPSRuntimeClassImporter);

function PSPluginCreate(): TPSPlugin; stdcall;

implementation


uses
   IdGlobal
  ,IdCoderMIME
  ,IdHash
  ,IdHashMessageDigest
  ,Encryption
  ;


function PSPluginCreate(): TPSPlugin; stdcall;
var
  Import: TPSImport_Encryption;
begin
  Import:= TPSImport_Encryption.Create(nil);
  Result := Import;
end;

(* === compile-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure SIRegister_THash(CL: TPSPascalCompiler);
begin
  //with RegClassS(CL,'TObject', 'THash') do

  with CL.AddClassN(CL.FindClass('TObject'),'THash') do
  begin
    RegisterMethod('Function EncodeMd5( const value : string) : string');
    RegisterMethod('Function EncodeBase64( const value : string) : string');
    RegisterMethod('Function DecodeBase64( const value : string) : string');
    RegisterMethod('Function EncodeSha2( const value: string; TypeOfSha: integer) : string');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure SIRegister_Encryption(CL: TPSPascalCompiler);
begin
  SIRegister_THash(CL);
end;

(* === run-time registration functions === *)
(*----------------------------------------------------------------------------*)
procedure RIRegister_THash(CL: TPSRuntimeClassImporter);
begin
  with CL.Add(THash) do
  begin
    RegisterMethod(@THash.EncodeMd5, 'EncodeMd5');
    RegisterMethod(@THash.EncodeBase64, 'EncodeBase64');
    RegisterMethod(@THash.DecodeBase64, 'DecodeBase64');
    RegisterMethod(@THash.EncodeSha2, 'EncodeSha2');
  end;
end;

(*----------------------------------------------------------------------------*)
procedure RIRegister_Encryption(CL: TPSRuntimeClassImporter);
begin
  RIRegister_THash(CL);
end;



{ TPSImport_Encryption }
(*----------------------------------------------------------------------------*)
procedure TPSImport_Encryption.CompileImport1(CompExec: TPSScript);
begin
  SIRegister_Encryption(CompExec.Comp);
end;
(*----------------------------------------------------------------------------*)
procedure TPSImport_Encryption.ExecImport1(CompExec: TPSScript; const ri: TPSRuntimeClassImporter);
begin
  RIRegister_Encryption(ri);
end;
(*----------------------------------------------------------------------------*)


end.
