DESTDIR=~/.vim

install:
	install plugin/cmake-project.vim ${DESTDIR}/plugin/
	install perl/VIM/CMakeProject.pm ${DESTDIR}/perl/VIM/

uninstall:
	rm ${DESTDIR}/plugin/cmake-project.vim
	rm ${DESTDIR}/perl/VIM/CMakeProject.pm