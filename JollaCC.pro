# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = JollaCC

CONFIG += sailfishapp

SOURCES += src/JollaCC.cpp

OTHER_FILES += qml/JollaCC.qml \
    qml/cover/CoverPage.qml \
    rpm/JollaCC.spec \
    rpm/JollaCC.yaml \
    JollaCC.desktop \
    qml/pages/MenuPage.qml \
    qml/pages/MoviesPage.qml \
    qml/pages/FinnkinoPage.qml \
    qml/pages/BluRayPage.qml \
    qml/pages/FinnkinoSinglePage.qml \
    qml/pages/NetflixPage.qml \
    qml/pages/NetflixSinglePage.qml

