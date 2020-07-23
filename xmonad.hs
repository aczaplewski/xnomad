--
--   ~/.xmonad/xmonad.hs
--
--                                                                                        -:r*>;,                         
--                                                                                     '{Q@QqZSeO#gS;                     
--                                                                                    \@Qv' `','  `;FDv`                  
--                                                                                   ;@W..uQ#KdQ@K_   rOv`                
--                                                                                   e@, #@^    ,X@?    =K.               
--                                                                              FQ,  eQ` Bk  ;v,  QB     '^;\\r:-         
--                                                                              QM   :@z .oqJFR; -@Z   'yNOt|*ioNQP;      
--      1Q?   /#t` :Quo9RQN;    /H&Dg#c    D91UDQQr:aqWQK'   _OOd8Qg^    ;KgHHEL@\    ^Nd;  ''  r#J`  \@v``^v]7;`:K@o`    
--       f@r;#K,   Z@u`   @W  ,BD,   :@j  ;@D,   #@]`  :@]   `     m@` `$Q:   ;@@`   \: ;jOq6Pewc'   ~@R ^Q:`'iQQ: J@9    
--        e@Q;    `@h    '@2  MQ`    `@w  h@`   `@P    >@^  'zOOq99@#  y@;    -@Z   la      `.'`     _@d :O=^  '@N `@@;   
--      'hQm@v    |@;    i@: -@&     v@; -@K    |@;    9Q` _@9-   ;@z  #@`    F@;  ,@_   ,jgRPoakKr   y@/  `   ;@u  @@;   
--    `FQv` \@7   D@     Ng   w@?'';$Q;  i@>    DQ    '@u  r@9'.:jQ@'  y@S'-:P@Q   vQ   ^@g,  ', `f#;  *QQk]czgQc  ]@h    
--   `\7`    ;z' `vr    `z:    :fmet;`   >v`   `zr    "t'   :uXZ7'\i    ;yXa/,tr   j@'  #@'  l^?8^ ?@'   ,?vv\~  _d@v`    
--                                                                                 ;@X  d@_  .  xZ `@?        ,LD8c.      
--                                                                                  6@Z`'D@e\|v8D' i@_:::;|]oPur-         
--                                                                                  `6@B| '>7v|, "9Q;  `--`               
--                                                                                    \N@QHozvu9QQ]-                      
--                                                                                      -;LtjFz=,                         
--                                                                                                                        
--                                                                                                                        
--
--   xnomad - an xmonad build by Alasdair R Czaplewski
--
--   you are reading version 3.0.2 for xmonad 0.15, implemented on 2020-07-20
--
--   does this version work yet? ||No||
--
--   
--
--
--   xnomad is tiling - maximising screen real estate in laptop mode, minimising effort when docked
--   xnomad is dynamic - behaviors optimised differently for use when docked vs on the move
--   xnomad is keyboard-only - no mice beyond this point
--   xnomad is workflow - intelligent preset workspaces adapt on the fly
--   xnomad is incapable - of displaying my wallpaper for some fucking reason
--
--
----------------------------------------- IMPORTS (passports at the ready, please) ----------------------------------------

import XMonad
import XMonad.Config.Gnome
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmproc <- spawnPipe "xmobar"

    xmonad $ gnomeConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock; xset dpms force off")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]
