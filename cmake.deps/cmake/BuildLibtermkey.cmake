if(USE_EXISTING_SRC_DIR)
  unset(LIBTERMKEY_URL)
endif()
ExternalProject_Add(libtermkey
  URL ${LIBTERMKEY_URL}
  URL_HASH SHA256=${LIBTERMKEY_SHA256}
  DOWNLOAD_NO_PROGRESS TRUE
  DOWNLOAD_DIR ${DEPS_DOWNLOAD_DIR}/libtermkey
  PATCH_COMMAND ${CMAKE_COMMAND} -E copy
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/libtermkeyCMakeLists.txt
    ${DEPS_BUILD_DIR}/src/libtermkey/CMakeLists.txt
  CMAKE_ARGS ${DEPS_CMAKE_ARGS}
    -DCMAKE_SHARED_LIBRARY_LINK_C_FLAGS="" # Hack to avoid -rdynamic in Mingw
    -DUNIBILIUM_INCLUDE_DIRS=${DEPS_INSTALL_DIR}/include
    -DUNIBILIUM_LIBRARIES=${DEPS_LIB_DIR}/${CMAKE_STATIC_LIBRARY_PREFIX}unibilium${CMAKE_STATIC_LIBRARY_SUFFIX}
  CMAKE_CACHE_ARGS ${DEPS_CMAKE_CACHE_ARGS})

list(APPEND THIRD_PARTY_DEPS libtermkey)
