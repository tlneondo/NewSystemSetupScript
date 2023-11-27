#setup corectrl
    sudo cp /usr/share/applications/org.corectrl.corectrl.desktop ~/.config/autostart/org.corectrl.corectrl.desktop

    sudo su -c "echo 'polkit.addRule(function(action, subject) {
        if ((action.id == "org.corectrl.helper.init" ||
            action.id == "org.corectrl.helperkiller.init") &&
            subject.local == true &&
            subject.active == true &&
            subject.isInGroup("your-user-group")) {
                return polkit.Result.YES;
        }
    });
    ' >> /etc/polkit-1/rules.d/90-corectrl.rules"
