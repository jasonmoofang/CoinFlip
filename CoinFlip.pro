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
TARGET = CoinFlip

CONFIG += sailfishapp

SOURCES += src/CoinFlip.cpp

OTHER_FILES += qml/CoinFlip.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/CoinFlip.changes.in \
    rpm/CoinFlip.spec \
    rpm/CoinFlip.yaml \
    translations/*.ts \
    CoinFlip.desktop \
    qml/img/tails.png \
    qml/img/heads.png

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

