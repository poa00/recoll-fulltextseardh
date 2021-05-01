TEMPLATE        = app
LANGUAGE        = C++


DEFINES += BUILDING_RECOLL

 QT += webkit
 DEFINES += USING_WEBKIT

# QT += webengine
# DEFINES += USING_WEBENGINE

QMAKE_CPPFLAGS *= $(shell dpkg-buildflags --get CPPFLAGS)
QMAKE_CFLAGS   *= $(shell dpkg-buildflags --get CFLAGS)
QMAKE_CXXFLAGS += -std=c++11 -D_FORTIFY_SOURCE=2
QMAKE_CXXFLAGS *= $(shell dpkg-buildflags --get CXXFLAGS)
QMAKE_LFLAGS   *= $(shell dpkg-buildflags --get LDFLAGS)

# QT += dbus
# QMAKE_CXXFLAGS += -DUSE_ZEITGEIST

QT += xml
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets printsupport

 greaterThan(QT_MAJOR_VERSION, 4): QT += webkitwidgets
# greaterThan(QT_MAJOR_VERSION, 4): QT += webenginewidgets

CONFIG  += qt warn_on thread release 

HEADERS += \
        advsearch_w.h \
        advshist.h \
        confgui/confgui.h \
        confgui/confguiindex.h \
        crontool.h \
        firstidx.h \
        fragbuts.h \
        idxsched.h \
        preview_load.h \
        preview_plaintorich.h \
        preview_w.h \
        ptrans_w.h \
        rclhelp.h \
        rclmain_w.h \
        reslist.h \
        restable.h \
        rtitool.h \
        searchclause_w.h \
        snippets_w.h \
        specialindex.h \
        spell_w.h \
        ssearch_w.h \
        systray.h \
        uiprefs_w.h \
        viewaction_w.h \
        webcache.h \
        widgets/editdialog.h \
        widgets/listdialog.h \
        widgets/qxtconfirmationmessage.h

SOURCES += \
        advsearch_w.cpp \
        advshist.cpp \
        confgui/confgui.cpp \
        confgui/confguiindex.cpp \
        crontool.cpp \
        fragbuts.cpp \
        guiutils.cpp \
        main.cpp \
        multisave.cpp \
        preview_load.cpp \
        preview_plaintorich.cpp \
        preview_w.cpp \
        ptrans_w.cpp \
        rclhelp.cpp \
        rclm_idx.cpp \
        rclm_preview.cpp \
        rclm_saveload.cpp \
        rclm_view.cpp \
        rclm_wins.cpp \
        rclmain_w.cpp \
        rclzg.cpp \
        reslist.cpp \
        respopup.cpp \
        restable.cpp \
        rtitool.cpp \
        searchclause_w.cpp \
        snippets_w.cpp \
        spell_w.cpp \
        ssearch_w.cpp \
        systray.cpp \
        uiprefs_w.cpp \
        viewaction_w.cpp \
        webcache.cpp \
        widgets/qxtconfirmationmessage.cpp \
        xmltosd.cpp

FORMS   = \
        advsearch.ui \
        crontool.ui \
        firstidx.ui \
        idxsched.ui \
        preview.ui \
        ptrans.ui \
        rclmain.ui \
        restable.ui \
        rtitool.ui \
        snippets.ui \
        specialindex.ui \
        spell.ui \
        ssearchb.ui \
        uiprefs.ui \
        viewaction.ui \
        webcache.ui \
        widgets/editdialog.ui \
        widgets/listdialog.ui 
        
RESOURCES = recoll.qrc

unix {
  UI_DIR = .ui
  MOC_DIR = .moc
  OBJECTS_DIR = .obj
  LIBS += -L../.libs -lrecoll

  !macx {
    # Note: libdir may be substituted with sthing like $(exec_prefix)/lib
    # at this point and will go as such in the Makefile. Expansion will be
    # completed at make time.
    LIBS += -Wl,-rpath=${prefix}/lib/x86_64-linux-gnu/recoll
  }

  LIBS +=   -L/usr/lib/x86_64-linux-gnu -lxapian $(LIBXAPIANSTATICEXTRA) \
        $(BDYNAMIC)  -lz

  INCLUDEPATH += ../common ./../common ./../index \
              ./../internfile ./../query ./../unac \
              ./../utils ./../aspell ./../rcldb \
              ./../qtgui ./../xaposix ./confgui \
              ./widgets
  DEPENDPATH += $$INCLUDEPATH
}

UNAME = $$system(uname -s)
contains( UNAME, [lL]inux ) {
	  LIBS += -ldl -lX11
}

contains( UNAME, SunOS ) {
          LIBS += -ldl
}

macx {
    ICON = images/recoll.icns
}

TRANSLATIONS = \
	     i18n/recoll_cs.ts \
	     i18n/recoll_da.ts \
	     i18n/recoll_de.ts \
	     i18n/recoll_el.ts \
	     i18n/recoll_es.ts \
             i18n/recoll_fr.ts \
             i18n/recoll_it.ts \
             i18n/recoll_ko.ts \             
             i18n/recoll_lt.ts \
             i18n/recoll_ru.ts \
             i18n/recoll_tr.ts \
             i18n/recoll_uk.ts \
             i18n/recoll_xx.ts \
             i18n/recoll_zh_CN.ts \
             i18n/recoll_zh.ts \

unix {
  isEmpty(PREFIX) {
    PREFIX = /usr/local
  }
  message("Prefix is $$PREFIX")
  DEFINES += PREFIX=\\\"$$PREFIX\\\"

 # Installation stuff
  target.path = "$$PREFIX/bin"

  imdata.files = ./mtpics/*.png
  imdata.path = $$PREFIX/share/recoll/images
  trdata.files = ./i18n/*.qm
  trdata.path = $$PREFIX/share/recoll/translations
  desktop.files += ./../desktop/recoll-searchgui.desktop
  desktop.path = $$PREFIX/share/applications/
  icona.files += ./../desktop/recoll.png
  icona.path = $$PREFIX/share/icons/hicolor/48x48/apps/
  iconb.files += ./../desktop/recoll.png
  iconb.path = $$PREFIX/share/pixmaps/
  appdata.files = ./../desktop/recoll.appdata.xml
  appdata.path = $$PREFIX/share/appdata/
  INSTALLS += target imdata trdata desktop icona iconb appdata

  # The recollinstall script used to do the following to install zh_CN as
  # zh. Is this still needed?
  #${INSTALL} -m 0444 ${I18N}/recoll_zh_CN.qm \
  #  ${datadir}/recoll/translations/recoll_zh.qm || exit 1
}
