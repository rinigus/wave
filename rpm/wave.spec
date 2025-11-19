Name:           wave
Version:        1.0.0
Release:        1%{?dist}
Summary:        Minimal web browser

License:        MIT and GPLv2+ and LGPLv2 and LGPLv2+
# For a breakdown of the licensing, see PACKAGE-LICENSING
URL:            https://github.com/rinigus/wave
Source0: %{name}-%{version}.tar.bz2


#BuildRequires:  appstream
BuildRequires:  cmake
BuildRequires:  desktop-file-utils
BuildRequires:  kf6-extra-cmake-modules
BuildRequires:  gcc
BuildRequires:  gcc-c++
BuildRequires:  kf6-rpm-macros
 
BuildRequires:  kf6-kconfig-devel
BuildRequires:  kf6-kcoreaddons-devel
BuildRequires:  kf6-kdbusaddons-devel
BuildRequires:  kf6-ki18n-devel
BuildRequires:  kf6-kirigami-devel
BuildRequires:  kf6-kirigami-addons-devel
BuildRequires:  kf6-knotifications-devel
BuildRequires:  kf6-qqc2-desktop-style
BuildRequires:  kf6-kwindowsystem-devel
BuildRequires:  futuresql-qt6-devel

BuildRequires:  qt6-qtbase-devel
BuildRequires:  qt6-qtmultimedia-devel
BuildRequires:  qt6-qtdeclarative-devel
BuildRequires:  qt6-qtquickcontrols2-devel
BuildRequires:  qt6-qtsvg-devel
BuildRequires:  qt6-qtwebengine-devel
BuildRequires:  qt6-qtwebsockets-devel
BuildRequires:  qt6-qtwebchannel-devel
BuildRequires:  qt6-qtlocation-devel
BuildRequires:  qt6-qtbase-private-devel

Requires: kf6-kirigami
Requires: kf6-kirigami-addons
Requires: qt6-qtmultimedia
Requires: qt6-qtsvg
Requires: qt6-qtlocation
Requires: qt6-qt5compat
Requires: kf6-breeze-icons

%description
Minimal Web browser for testing

%prep
%autosetup -n %{name}-%{version}

%build
%cmake_kf6
%cmake_build

%install
%cmake_install

%files

%{_bindir}/%{name}
%{_kf6_datadir}/config.kcfg/%{name}settings.kcfg
