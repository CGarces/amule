ADD_SUBDIRECTORY (docs)
ADD_SUBDIRECTORY (src)

IF (BUILD_ALC)
	INSTALL (FILES alc.xpm
		DESTINATION "${CMAKE_INSTALL_DATADIR}/pixmaps"
	)

	INSTALL (FILES alc.desktop
		DESTINATION "${CMAKE_INSTALL_DATADIR}/applications"
	)
ENDIF (BUILD_ALC)
