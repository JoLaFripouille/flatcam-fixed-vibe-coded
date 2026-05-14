#define MyAppName "FlatCAM Fixed Vibe Coded"
#define MyAppShortName "FlatCAM Fixed"
#define MyAppVersion "0.1.0"
#define MyAppPublisher "JoLaFripouille"
#define MyAppURL "https://github.com/JoLaFripouille/flatcam-fixed-vibe-coded"
#define SourceRoot ".."

[Setup]
AppId={{D6F0F748-3E6D-44C0-88F2-5145D6E76F2C}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={localappdata}\Programs\FlatCAM Fixed
DefaultGroupName={#MyAppShortName}
DisableProgramGroupPage=yes
LicenseFile={#SourceRoot}\LICENSE
OutputDir={#SourceRoot}\dist
OutputBaseFilename=FlatCAM-Fixed-Setup
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=lowest
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64
UninstallDisplayName={#MyAppName}
SetupIconFile={#SourceRoot}\assets\linux\icon.ico

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
Source: "{#SourceRoot}\*.py"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceRoot}\flatcam-beta.1"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceRoot}\CHANGELOG.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceRoot}\FORK_NOTES.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceRoot}\LICENSE"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceRoot}\README.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceRoot}\requirements.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceRoot}\appCommon\*"; DestDir: "{app}\appCommon"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\appEditors\*"; DestDir: "{app}\appEditors"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\appGUI\*"; DestDir: "{app}\appGUI"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\appHandlers\*"; DestDir: "{app}\appHandlers"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\appObjects\*"; DestDir: "{app}\appObjects"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\appParsers\*"; DestDir: "{app}\appParsers"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\appPlugins\*"; DestDir: "{app}\appPlugins"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\assets\*"; DestDir: "{app}\assets"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\config\*"; DestDir: "{app}\config"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\descartes\*"; DestDir: "{app}\descartes"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\doc\*"; DestDir: "{app}\doc"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\docs\*"; DestDir: "{app}\docs"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\libs\*"; DestDir: "{app}\libs"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\locale\*"; DestDir: "{app}\locale"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\locale_template\*"; DestDir: "{app}\locale_template"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\preprocessors\*"; DestDir: "{app}\preprocessors"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\scripts\*"; DestDir: "{app}\scripts"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\tclCommands\*"; DestDir: "{app}\tclCommands"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\Utils\*"; DestDir: "{app}\Utils"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"
Source: "{#SourceRoot}\build\python-runtime\*"; DestDir: "{app}\runtime"; Flags: ignoreversion recursesubdirs createallsubdirs; Excludes: "*.pyc,__pycache__\*"

[Icons]
Name: "{group}\{#MyAppShortName}"; Filename: "{app}\runtime\pythonw.exe"; Parameters: "-s ""{app}\flatcam.py"""; WorkingDir: "{app}"; IconFilename: "{app}\assets\linux\icon.ico"
Name: "{group}\Désinstaller {#MyAppShortName}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppShortName}"; Filename: "{app}\runtime\pythonw.exe"; Parameters: "-s ""{app}\flatcam.py"""; WorkingDir: "{app}"; IconFilename: "{app}\assets\linux\icon.ico"; Tasks: desktopicon

[Run]
Filename: "{app}\runtime\python.exe"; Parameters: "-s -c ""import PyQt6, shapely, rasterio; print('FlatCAM Fixed install OK')"""; WorkingDir: "{app}"; Flags: runhidden
Filename: "{app}\runtime\pythonw.exe"; Parameters: "-s ""{app}\flatcam.py"""; WorkingDir: "{app}"; Description: "Lancer {#MyAppShortName}"; Flags: nowait postinstall skipifsilent
