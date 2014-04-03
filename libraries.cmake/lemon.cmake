##################################################
###       lemon   														 ###
##################################################

## build and install lemon
macro( OPENMS_CONTRIB_BUILD_LEMON )

  OPENMS_LOGHEADER_LIBRARY("lemon")

	if(MSVC)
    set(ZIP_ARGS "x -y -osrc")
  else()
    set(ZIP_ARGS "xzf")
  endif()
  OPENMS_SMARTEXTRACT(ZIP_ARGS ARCHIVE_LEMON "LEMON" "CMakeLists.txt")

  set(_LEMON_BUILD_DIR "${LEMON_DIR}/build")
  file(TO_NATIVE_PATH "${_LEMON_BUILD_DIR}" _LEMON_NATIVE_BUILD_DIR)

  execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${_LEMON_NATIVE_BUILD_DIR})

	message(STATUS "Generating lemon build system .. ")
  execute_process(COMMAND ${CMAKE_COMMAND}
												-G "${CMAKE_GENERATOR}"
												-D CMAKE_INSTALL_PREFIX=${PROJECT_BINARY_DIR}
												${LEMON_DIR}
									WORKING_DIRECTORY ${_LEMON_NATIVE_BUILD_DIR}
									OUTPUT_VARIABLE _LEMON_CMAKE_OUT
									ERROR_VARIABLE _LEMON_CMAKE_ERR
									RESULT_VARIABLE _LEMON_CMAKE_SUCCESS)

  # output to logfile
  file(APPEND ${LOGFILE} ${_LEMON_CMAKE_OUT})
  file(APPEND ${LOGFILE} ${_LEMON_CMAKE_ERR})

	if (NOT _LEMON_CMAKE_SUCCESS EQUAL 0)
		message(FATAL_ERROR "Generating lemon build system .. failed")
	else()
		message(STATUS "Generating lemon build system .. done")
	endif()

  # the install target on windows has a different name then on mac/lnx
  if(MSVC)
      set(_LEMON_INSTALL_TARGET "INSTALL")
  else()
      set(_LEMON_INSTALL_TARGET "install")
  endif()


	message(STATUS "Installing lemon headers .. ")
	execute_process(COMMAND ${CMAKE_COMMAND} --build ${_LEMON_NATIVE_BUILD_DIR} --target ${_LEMON_INSTALL_TARGET} --config Release
									WORKING_DIRECTORY ${_LEMON_NATIVE_BUILD_DIR}
									OUTPUT_VARIABLE _LEMON_BUILD_OUT
									ERROR_VARIABLE _LEMON_BUILD_ERR
									RESULT_VARIABLE _LEMON_BUILD_SUCCESS)

	# output to logfile
	file(APPEND ${LOGFILE} ${_LEMON_BUILD_OUT})
	file(APPEND ${LOGFILE} ${_LEMON_BUILD_ERR})

	if (NOT _LEMON_BUILD_SUCCESS EQUAL 0)
		message(FATAL_ERROR "Installing lemon headers .. failed")
	else()
		message(STATUS "Installing lemon headers .. done")
	endif()
endmacro( OPENMS_CONTRIB_BUILD_LEMON )
