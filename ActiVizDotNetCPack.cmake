SET(CPACK_PACKAGE_NAME "ActiViz.NET")
SET(CPACK_PACKAGE_VERSION_MAJOR "${AVDN_MAJOR_VERSION}")
SET(CPACK_PACKAGE_VERSION_MINOR "${AVDN_MINOR_VERSION}")
SET(CPACK_PACKAGE_VERSION_PATCH "${AVDN_BUILD_VERSION}")
SET(CPACK_PACKAGE_VERSION "${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}")
SET(CPACK_PACKAGE_INSTALL_DIRECTORY "${CPACK_PACKAGE_NAME} ${CPACK_PACKAGE_VERSION} ${AVDN_EDITION} Edition")
SET(CPACK_PACKAGE_VENDOR "Kitware, Inc.")
SET(CPACK_PACKAGE_DESCRIPTION_FILE "${ActiVizDotNet_SOURCE_DIR}/License${AVDN_EDITION_SUFFIX}.txt")
SET(CPACK_RESOURCE_FILE_LICENSE "${ActiVizDotNet_SOURCE_DIR}/License${AVDN_EDITION_SUFFIX}.txt")

SET(CPACK_SOURCE_PACKAGE_FILE_NAME
  "${CPACK_PACKAGE_NAME}-${AVDN_MAJOR_VERSION}.${AVDN_MINOR_VERSION}.${AVDN_BUILD_VERSION}.${AVDN_VERSION_SVN_REVISION}")

# Installers for 32- vs. 64-bit:
#  - Root install directory (displayed to end user at installer-run time)
#  - "NSIS package/display name" (text used in the installer GUI)
#  - Registry key used to store info about the installation
#
# This bit requires CPack 2.8.4 or later, because CPACK_NSIS_INSTALL_ROOT is
# ignored by previous versions of CPack.
#
IF(CMAKE_CL_64)
  SET(CPACK_NSIS_INSTALL_ROOT "$PROGRAMFILES64")
  SET(CPACK_NSIS_PACKAGE_NAME "${CPACK_PACKAGE_INSTALL_DIRECTORY} (Win64)")
  SET(CPACK_NSIS_DISPLAY_NAME "${CPACK_PACKAGE_INSTALL_DIRECTORY} (Win64)")
  SET(CPACK_PACKAGE_INSTALL_REGISTRY_KEY "${CPACK_PACKAGE_INSTALL_DIRECTORY} (Win64)")
ELSE()
  SET(CPACK_NSIS_INSTALL_ROOT "$PROGRAMFILES")
  SET(CPACK_NSIS_PACKAGE_NAME "${CPACK_PACKAGE_INSTALL_DIRECTORY}")
  SET(CPACK_NSIS_DISPLAY_NAME "${CPACK_PACKAGE_INSTALL_DIRECTORY}")
  SET(CPACK_PACKAGE_INSTALL_REGISTRY_KEY "${CPACK_PACKAGE_INSTALL_DIRECTORY}")
ENDIF()

SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "${CPACK_NSIS_DISPLAY_NAME} - the scientific data visualization power of VTK harnessed for C#, VB.NET or any other .NET Framework language.")

IF(NOT DEFINED CPACK_SYSTEM_NAME)
  SET(CPACK_SYSTEM_NAME ${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_PROCESSOR})
ENDIF(NOT DEFINED CPACK_SYSTEM_NAME)
IF(CPACK_SYSTEM_NAME MATCHES Windows)
  IF(CMAKE_CL_64)
    SET(CPACK_SYSTEM_NAME win64)
  ELSE(CMAKE_CL_64)
    SET(CPACK_SYSTEM_NAME win32)
  ENDIF(CMAKE_CL_64)
ENDIF(CPACK_SYSTEM_NAME MATCHES Windows)

IF(NOT DEFINED CPACK_PACKAGE_FILE_NAME)
  SET(CPACK_PACKAGE_FILE_NAME "${CPACK_SOURCE_PACKAGE_FILE_NAME}-${CPACK_SYSTEM_NAME}-${AVDN_EDITION}")
ENDIF(NOT DEFINED CPACK_PACKAGE_FILE_NAME)

IF(WIN32)
  # CPACK_PACKAGE_ICON: the installer banner bitmap (*.bmp file)
  SET(icon_file "${ActiVizDotNet_SOURCE_DIR}/Logos/activizinstall.bmp")
  # Use Windows style path separator in NSIS script:
  STRING(REGEX REPLACE "/" "\\\\\\\\" icon_file "${icon_file}")
  SET(CPACK_PACKAGE_ICON "${icon_file}")

  # CPACK_NSIS_MUI_ICON: the installer executable icon (*.ico file)
  SET(icon_file "${ActiVizDotNet_SOURCE_DIR}/Logos/icon128x128 install.ico")
  # Use Windows style path separator in NSIS script:
  STRING(REGEX REPLACE "/" "\\\\\\\\" icon_file "${icon_file}")
  SET(CPACK_NSIS_MUI_ICON "${icon_file}")

  # CPACK_NSIS_MUI_UNIICON: the uninstaller executable icon (*.ico file)
  SET(icon_file "${ActiVizDotNet_SOURCE_DIR}/Logos/icon128x128 uninstall.ico")
  # Use Windows style path separator in NSIS script:
  STRING(REGEX REPLACE "/" "\\\\\\\\" icon_file "${icon_file}")
  SET(CPACK_NSIS_MUI_UNIICON "${icon_file}")

  SET(CPACK_NSIS_HELP_LINK "http://www.kitware.com/products/activiz.html")
  SET(CPACK_NSIS_URL_INFO_ABOUT "http://www.kitware.com")
  SET(CPACK_NSIS_CONTACT "kitware@kitware.com")

  SET(CPACK_NSIS_EXTRA_INSTALL_COMMANDS "
  CreateShortCut \\\"$SMPROGRAMS\\\\$STARTMENU_FOLDER\\\\Examples.lnk\\\" \\\"$INSTDIR\\\\Examples\\\"
  CreateShortCut \\\"$SMPROGRAMS\\\\$STARTMENU_FOLDER\\\\License.lnk\\\" \\\"$INSTDIR\\\\License${AVDN_EDITION_SUFFIX}.txt\\\"
  CreateShortCut \\\"$SMPROGRAMS\\\\$STARTMENU_FOLDER\\\\Users Guide.lnk\\\" \\\"$INSTDIR\\\\UsersGuide.pdf\\\"
  CreateShortCut \\\"$SMPROGRAMS\\\\$STARTMENU_FOLDER\\\\Event Monitor.lnk\\\" \\\"$INSTDIR\\\\bin\\\\EventMonitor.exe\\\"
  CreateShortCut \\\"$SMPROGRAMS\\\\$STARTMENU_FOLDER\\\\File Browser.lnk\\\" \\\"$INSTDIR\\\\bin\\\\FileTree.exe\\\"
")

  SET(CPACK_NSIS_EXTRA_UNINSTALL_COMMANDS "
  !insertmacro MUI_STARTMENU_GETFOLDER Application $MUI_TEMP
  Delete \\\"$SMPROGRAMS\\\\$MUI_TEMP\\\\File Browser.lnk\\\"
  Delete \\\"$SMPROGRAMS\\\\$MUI_TEMP\\\\Event Monitor.lnk\\\"
  Delete \\\"$SMPROGRAMS\\\\$MUI_TEMP\\\\Users Guide.lnk\\\"
  Delete \\\"$SMPROGRAMS\\\\$MUI_TEMP\\\\License.lnk\\\"
  Delete \\\"$SMPROGRAMS\\\\$MUI_TEMP\\\\Examples.lnk\\\"
")

  SET(CPACK_GENERATOR "NSIS")
  SET(CPACK_SOURCE_GENERATOR "${CPACK_GENERATOR}")
ENDIF(WIN32)

INCLUDE(CPack)
