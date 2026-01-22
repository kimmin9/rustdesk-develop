[Setup]
AppName=MyCustomRustDesk
AppVersion=1.0
DefaultDirName={autopf}\MyCustomRustDesk
DefaultGroupName=MyCustomRustDesk
; 설치 시 관리자 권한 요구 (서비스 등록을 위해 필요)
PrivilegesRequired=admin
OutputDir=.
OutputBaseFilename=CustomRustDesk_Setup
Compression=lzma
SolidCompression=yes
SetupIconFile=res\logo.ico

[Files]
; 빌드된 결과물을 설치 폴더로 복사
Source: "target\release\rustdesk.exe"; DestDir: "{app}"; Flags: ignoreversion
; 필요한 DLL이나 리소스가 있다면 추가 (예: sciter.dll 등)
; Source: "target\release\*.dll"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\MyCustomRustDesk"; Filename: "{app}\rustdesk.exe"
Name: "{autodesktop}\MyCustomRustDesk"; Filename: "{app}\rustdesk.exe"

[Run]
; 1. 서비스 등록 (RustDesk 자체 서비스 등록 인자 사용)
Filename: "{app}\rustdesk.exe"; Parameters: "--install-service"; Flags: runhidden
; 2. 설치 완료 후 프로그램 실행 (백그라운드 모드로 실행)
Filename: "{app}\rustdesk.exe"; Description: "Launch RustDesk"; Flags: nowait postinstall skipifsilent

[UninstallRun]
; 삭제 시 서비스 먼저 제거
Filename: "{app}\rustdesk.exe"; Parameters: "--uninstall-service"; Flags: runhidden
