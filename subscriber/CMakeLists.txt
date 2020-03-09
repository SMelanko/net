cmake_minimum_required(VERSION 3.16.0)

project(subscriber CXX)

add_executable(${PROJECT_NAME}
    main.cpp
    Subscriber.h
    ZmqSubscriber.cpp
    ZmqSubscriber.h
)

target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_17)

target_include_directories(${PROJECT_NAME}
    PUBLIC
        .. # for zhelpers.hpp
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        CONAN_PKG::cppzmq
        CONAN_PKG::fmt
        CONAN_PKG::spdlog
        net::utils
)

target_link_options(${PROJECT_NAME}
    PRIVATE
        $<$<CXX_COMPILER_ID:MSVC>:
            /ignore:4099 # warning LNK4099: PDB '.pdb' was not found ...
        >
)