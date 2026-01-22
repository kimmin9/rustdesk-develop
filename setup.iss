[Setup]
AppName=MyCustomRustDesk
AppVersion=1.0
DefaultDirName={autopf}\MyCustomRustDesk
DefaultGroupName=MyCustomRustDesk
PrivilegesRequired=admin
OutputDir=.
OutputBaseFilename=CustomRustDesk_Setup
Compression=lzma
SolidCompression=yes
; 아이콘 에러 방지를 위해 확실히 주석 처리
;SetupIconFile=res\logo.ico

[Files]
; 빌드 스크립트 특성상 루트 폴더에 exe가 있을 확률이 높으므로 아래와 같이 수정합니다.
; 만약 target 폴더에 있다면 "target\release\rustdesk.exe"로 다시 바꾸면 됩니다.
Source: "rustdesk.exe"; DestDir: "{app}"; Flags: ignoreversion
; Flutter 빌드 시 필요한 DLL들이 있다면 함께 포함해야 실행됩니다.
Source: "*.dll"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\MyCustomRustDesk"; Filename: "{app}\rustdesk.exe"
Name: "{autodesktop}\MyCustomRustDesk"; Filename: "{app}\rustdesk.exe"

[Run]
; 1. 서비스 등록
Filename: "{app}\rustdesk.exe"; Parameters: "--install-service"; Flags: runhidden
; 2. 서비스 시작 (등록만 하고 시작을 안 할 경우를 대비)
Filename: "sc"; Parameters: "start RustDesk"; Flags: runhidden
; 3. 설치 완료 후 사용자에게 실행창 표시
Filename: "{app}\rustdesk.exe"; Description: "Launch RustDesk"; Flags: nowait postinstall skipifsilent

[UninstallRun]
; 삭제 시 서비스 중지 및 제거
Filename: "sc"; Parameters: "stop RustDesk"; Flags: runhidden
Filename: "{app}\rustdesk.exe"; Parameters: "--uninstall-service"; Flags: runhidden
