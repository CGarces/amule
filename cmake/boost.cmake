include (FindThreads)
find_package (Boost ${MIN_BOOST_VERSION})

if (NOT ASIO_SOCKETS)
	include (CheckIncludeFiles)

	if (WIN32)
		set (Boost_USE_STATIC_LIBS TRUE)
	endif()

	if (Boost_FOUND)
		set (CMAKE_REQUIRED_INCLUDES ${Boost_INCLUDE_DIRS})

		if (NOT WIN32)
			set (CMAKE_REQUIRED_FLAGS "-DBOOST_ERROR_CODE_HEADER_ONLY")
		else()
			set (CMAKE_REQUIRED_FLAGS " -DBOOST_DATE_TIME_NO_LIB -DBOOST_REGEX_NO_LIB -DBOOST_SYSTEM_NO_LIB -DBOOST_ERROR_CODE_HEADER_ONLY")
		endif (NOT WIN32)

		set (CMAKE_REQUIRED_LIBRARIES "Threads::Threads")
		check_include_files ("boost/system/error_code.hpp;boost/asio.hpp" ASIO_SOCKETS LANGUAGE CXX)

		if (ASIO_SOCKETS)
			set (Boost_LIBRARIES ${CMAKE_REQUIRED_LIBRARIES} CACHE STRING "Libraries needed for linking with boost" FORCE)
			set (BOOST_ERROR_CODE_HEADER_ONLY TRUE CACHE INTERNAL "When true, boost_system lib is not needed for linking" FORCE)
			unset (CMAKE_REQUIRED_INCLUDES)
			unset (CMAKE_REQUIRED_FLAGS)
			unset (CMAKE_REQUIRED_LIBRARIES)
		else()
			if (NOT DOWNLOAD_AND_BUILD_DEPS)
				message (STATUS "No useable boost headers found. Disabling support")
				set (ENABLE_BOOST FALSE)
			endif()
		endif()
	else()
		message (STATUS "No useable boost headers found. Disabling support")
		set (ENABLE_BOOST FALSE)
	endif()
endif()
