# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-coinflip

CONFIG += sailfishapp

SOURCES += src/harbour-coinflip.cpp

OTHER_FILES += qml/harbour-coinflip.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/harbour-coinflip.changes.in \
    rpm/harbour-coinflip.spec \
    rpm/harbour-coinflip.yaml \
    translations/*.ts \
    harbour-coinflip.desktop \
    qml/img/tails.png \
    qml/img/heads.png \
    qml/img/cover.png

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

