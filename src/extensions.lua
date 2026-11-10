

-- Časově podmíněné směrování (Po-Pá 08:00-16:00) v LUA
extensions = {
    ["time-routing"] = {
        ["200"] = function(context, extension)
            app.noop("--- Příchozí hovor: Kontrola pracovní doby (LUA) ---")
            app.gotoiftime("08:00-16:00,mon-fri,*,*?open:closed")
        end;
        ["open"] = function()
            app.noop("--- Stav: OTEVŘENO ---")
            app.dial("PJSIP/101", 20)
            app.hangup()
        end;
        ["closed"] = function()
            app.noop("--- Stav: ZAVŘENO ---")
            app.playback("tt-monkeys")
            app.hangup()
        end;
    };
}
