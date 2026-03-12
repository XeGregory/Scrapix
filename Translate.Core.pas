unit Translate.Core;

interface

uses
  {System}
  System.SysUtils, System.Classes, System.Generics.Collections, System.SyncObjs;

type
  // Type énuméré représentant les langues supportées
  TLang = (lgFrench, lgEnglish);

  { Définitions publiques
    - SetLanguage : change la langue courante (thread-safe)
    - GetLanguage : retourne la langue courante (thread-safe)
    - GetTranslate : retourne la chaîne traduite correspondant à une clé
    - RegisterText : enregistre une traduction pour une clé donnée
  }

procedure SetLanguage(ALang: TLang);
function GetLanguage: TLang;
function GetTranslate(const Key: string): string;
procedure RegisterText(const Key, FrenchText, EnglishText: string);

implementation

var
  // Verrou pour protéger l'accès concurrent à CurrentLang et Texts
  LangLock: TCriticalSection;
  // Langue courante utilisée par GetTranslate
  CurrentLang: TLang;
  // Dictionnaire stockant les traductions : Key -> [fr, en]
  Texts: TDictionary<string, TArray<string>>; // Key -> [fr, en]

  { InitDefaults
    Initialise les traductions par défaut utilisées par l'application.
    Appelle RegisterText pour chaque clé afin de remplir le dictionnaire.
  }
procedure InitDefaults;
begin
  // Boutons
  RegisterText('BtnStart', 'Démarrer', 'Start');
  RegisterText('BtnBreak_Pause', 'Pause', 'Break');
  RegisterText('BtnBreak_Resume', 'Reprendre', 'Resume');
  RegisterText('BtnStop', 'Arrêter', 'Stop');
  RegisterText('InProgress', 'En cours...', 'In progress...');

  // Messages utilisateur
  RegisterText('PleaseProvideUrl', 'Veuillez fournir une URL de départ.',
    'Please provide a starting URL.');
  RegisterText('StopOrPauseToOpen',
    'Arrêtez ou mettez en pause l''exploration pour ouvrir le lien.',
    'Stop or pause the crawl before opening the link.');
  RegisterText('InvalidUrl', 'URL invalide : ', 'Invalid URL: ');

  // Titres de colonnes ListView
  RegisterText('Col0', 'Exploration', 'Exploration');
  RegisterText('Col1', 'Statut', 'Statut');
  RegisterText('Col2', 'Téléchargement', 'Download');
  RegisterText('Col3', 'Temps de réponse (ms)', 'Response time (ms)');
  RegisterText('Col4', 'Taille', 'Size');
  RegisterText('Col5', 'Profondeur', 'Depth');
  RegisterText('Col6', 'Type de requête', 'Query type');

  // États et sous-items
  RegisterText('Broken', 'Corrompu', 'Broken');
  RegisterText('Broken_Ignored', 'Corrompu (ignoré)', 'Broken (ignored)');
  RegisterText('BlockedByRobots', 'Bloqué par robots.txt',
    'Blocked by robots.txt');
  RegisterText('Ignored', 'Ignoré', 'Ignored');
  RegisterText('Downloading', 'Téléchargement', 'Downloading');
  RegisterText('Downloaded', 'Téléchargé', 'Downloaded');
  RegisterText('DownloadFailed', 'Échec téléchargement', 'Download failed');
  RegisterText('NotDownloaded', 'Non téléchargé', 'Not downloaded');
  RegisterText('NoResponse', 'Pas de réponse', 'No response');
  RegisterText('OnHold', 'En attente', 'On hold');

  // Labels et cases à cocher
  RegisterText('LabDepth', 'Profondeur d''exploration', 'Exploration depth');
  RegisterText('CkSameDomain', 'Limiter au même domaine',
    'Limit to the same domain');
  RegisterText('CkRobot', 'Respecter les directives Robots.txt',
    'Respect Robots.txt directives');
  RegisterText('LabExploreLimit', 'Limite d''exploration', 'Exploration limit');
  RegisterText('LabFoundFilesLimit', 'Limite fichiers trouvés',
    'Limit files found');
  RegisterText('LabTimeout', 'Temps d''attente par requête (ms)',
    'Wait time per request (ms)');
  RegisterText('LabDelay', 'Délai entre requêtes (ms)',
    'Delay between requests (ms)');
  RegisterText('LabListFileTypes', 'Types de fichiers à rechercher',
    'File types to search for');
  RegisterText('CkAutoDownload', 'Téléchargement automatique',
    'Automatic download');
  RegisterText('LabReport', 'Rapport d''exploration', 'Crawl Report');
  RegisterText('CkSaveBrokenLinks', 'Rapport des liens corrompus',
    'Report corrupted links');
  RegisterText('CkSaveBrokenToFile', 'Rapport des pages visitées',
    'Report of visited pages');
  RegisterText('CkSaveFoundFilesToFile', 'Rapport des fichiers trouvés',
    'Report of found files');

  // Texte de la barre d'état
  RegisterText('Panel0', 'Fichiers trouvés ', 'Files found ');
  RegisterText('Panel2', 'Liens corrompus ', 'Corrupted links ');
  RegisterText('Panel4', 'Bloqué par robots.txt ', 'Blocked by robots.txt ');
  RegisterText('Panel6', 'Liens parcourus ', 'Links browsed ');

  // Observateur d'événements
  RegisterText('ExPanelLog', 'Observateur d''événements', 'Event Viewer');

  RegisterText('BrokenLinkLog', 'Lien corrompues : %s','Corrupted link: %s');
  RegisterText('BlockedRobotsHEADLog', 'Bloqué par le robots (HEAD) : %s',
    'Blocked by robots (HEAD): %s');
  RegisterText('NoResponseHEADLog', 'Aucune réponse HEAD pour %s',
    'No response HEAD for %s');
  RegisterText('BlockedRobotsDownLog',
    'Bloqué par le robots (Téléchargement) : %s',
    'Blocked by robots (Download): %s');
  RegisterText('DonwLog', 'Téléchargé %s -> %s', 'Downloaded %s -> %s');
  RegisterText('DonwFailedLog', 'Échec du téléchargement %s',
    'Download failed %s');
  RegisterText('ExcepDonwLog', 'Exception de téléchargement %s : %s',
    'Download exception %s : %s');
  RegisterText('BlockedRobotsResLog', 'Bloqué par le robots (Resource) : %s',
    'Blocked by robots (Resource) : %s');
  RegisterText('FoundNotDownLog', 'Trouvé (Non téléchargé) : %s',
    'Found (Not downloaded): %s');
  RegisterText('CorruptedDownLog',
    'Lien corrompue (Téléchargement automatique) : %s',
    'Corrupted link (Automatic download) : %s');
  RegisterText('BlockedRobotsLog', 'Bloqué par le robots (Récursif) : %s',
    'Blocked by robots (Recursive) : %s');
  RegisterText('VisitedLog', 'Visité : %s (Profondeur = %d)',
    'Visited : %s (Depth = %d)');
  RegisterText('MarkBrokenLinkLog', 'Aucun contenu / lien corrompues : %s',
    'No content / Corrupted link : %s');
  RegisterText('NoContentLog', 'Aucun contenu (ignoré) : %s',
    'No content (ignored): %s');
  RegisterText('StartingLog',
    'Scrapix : démarrage de l''exploration de %s (MaxDepth = %d)',
    'Scrapix: Starting to crawl %s (MaxDepth = %d)');
  RegisterText('LaunchingLog',
    'Scrapix : lancement de l''exploration récursive',
    'Scrapix: launching recursive exploration');
  RegisterText('FinishedLog',
    'Scrapix : Exploration terminée. Fichiers trouvés = %d , Liens corrompus = %d , Liens parcourus = %d',
    'Scrapix: Crawling complete. Files found = %d , Corrupted links = %d , Links browsed = %d');
end;

{ SetLanguage
  Définit la langue courante de façon thread-safe en protégeant l'affectation
  par un TCriticalSection afin d'éviter les conditions de concurrence.
}
procedure SetLanguage(ALang: TLang);
begin
  LangLock.Enter;
  try
    CurrentLang := ALang;
  finally
    LangLock.Leave;
  end;
end;

{ GetLanguage
  Retourne la langue courante de façon thread-safe en accédant à CurrentLang
  sous protection du verrou LangLock.
}
function GetLanguage: TLang;
begin
  LangLock.Enter;
  try
    Result := CurrentLang;
  finally
    LangLock.Leave;
  end;
end;

{ GetTranslate
  Recherche la traduction correspondant à Key dans le dictionnaire Texts.
  - Si la clé est vide, retourne immédiatement une chaîne vide.
  - Si la clé n'existe pas, retourne la clé elle-même comme fallback.
  - Sélectionne l'élément francais ou anglais suivant CurrentLang.
  L'accès au dictionnaire est protégé par LangLock pour être thread-safe.
}
function GetTranslate(const Key: string): string;
var
  Arr: TArray<string>;
begin
  Result := Key; // fallback si aucune traduction trouvée
  if Key = '' then
    Exit;
  LangLock.Enter;
  try
    // Vérifie que Texts est initialisé et que la clé existe
    if (Texts <> nil) and Texts.TryGetValue(Key, Arr) then
    begin
      case CurrentLang of
        lgFrench:
          if Length(Arr) > 0 then
            Result := Arr[0]; // français
        lgEnglish:
          if Length(Arr) > 1 then
            Result := Arr[1]; // anglais
      end;
    end;
  finally
    LangLock.Leave;
  end;
end;

{ RegisterText
  Enregistre ou met à jour la traduction pour une clé donnée.
  - Ignore les clés vides.
  - Alloue le tableau de 2 éléments [fr, en].
  - Si le dictionnaire n'existe pas encore, le crée.
  - Utilise AddOrSetValue pour ajouter ou remplacer la valeur existante.
  L'opération est thread-safe via LangLock.
}
procedure RegisterText(const Key, FrenchText, EnglishText: string);
var
  Arr: TArray<string>;
begin
  if Key.IsEmpty then
    Exit;
  LangLock.Enter;
  try
    SetLength(Arr, 2);
    Arr[0] := FrenchText;
    Arr[1] := EnglishText;
    if Texts = nil then
      Texts := TDictionary < string, TArray < string >>.Create;
    Texts.AddOrSetValue(Key, Arr);
  finally
    LangLock.Leave;
  end;
end;

{ Bloc d'initialisation
  - Crée le verrou LangLock.
  - Définit la langue par défaut (ici français).
  - Crée le dictionnaire Texts.
  - Remplit les traductions par défaut via InitDefaults.
}
initialization

LangLock := TCriticalSection.Create;
CurrentLang := lgFrench; // valeur par défaut
Texts := TDictionary < string, TArray < string >>.Create;
InitDefaults;

{ Bloc de finalisation
  - Libère les ressources allouées dans l'initialization.
  - Important de libérer Texts avant LangLock si le dictionnaire utilise des sections critiques.
}
finalization

Texts.Free;
LangLock.Free;

end.
