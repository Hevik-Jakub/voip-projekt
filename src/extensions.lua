extensions = {
    ["time-routing"] = {
        ["200"] = function(context, extension)
            app.noop("--- Kontrola casu, fronty a schranky (LUA) ---")
            app.gotoiftime("08:00-16:00,mon-fri,*,*?open:closed")
        end;
        ["open"] = function()
            app.noop("--- OTEVRENO: Vstup do fronty ---")
            app.queue("recepce_fronta","t","","","30")
            app.goto("time-routing", "closed", 1) -- Pokud nikdo nezvedne, jdi do schránky
        end;
        ["closed"] = function()
            app.noop("--- ZAVRENO: Voicemail ---")
            app.playback("tt-monkeys")
            app.voicemail("101@default", "u")
            app.hangup()
        end;
    };
}
