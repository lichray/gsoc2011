=================================
Multibyte Encoding Support in Nvi
=================================

Abstract
========
*Nvi* is a BSD-licensed re-implementation of the original vi editor. While most of the userland tools in the FreeBSD base system support multibyte encodings [1]_, there is no nvi fork comes with sufficient multibyte encoding (both Unicode and non-Unicode) support so far. My GSoC2011 proposal aims to add the complete iconv-based multibyte encoding support to nvi. 

About me
========
I am Zhihao Yuan, a junior student majoring in Computer Science in the Northern Illinois University. I use `lichray` as my ID on the Internet. 

I have been using FreeBSD for five years, and I started to submit PR two months ago. The reason that I contribute to FreeBSD is `miwi@`'s "call"[2]_. The ATI and Xfce update problems referred by his article are found and solved by me. Currently, I only maintain 2 ports, but I have about 10 ports to be committed (some of them were sent to the committers directly). 

Nvi is written in C, and relies on ncurses; this project will add the iconv support to nvi. I program in C with vim since 2004, and I am familiar with the UNIX system programming. I got two A's for both of my UNIX and Operating System Principles courses. However, I did not use libiconv in the projects I participated before. But as a Chinese user, I do have sufficient knowledge and experience with character sets, encodings, and even endianness. So basically, to complete this project, I need to learn the `libiconv` and some `ncurses` programming. 

Availability
------------

I have a full-time job in this summer (at Fermilab), but I still want to participate in GSoC, since I am sure I have the ability to handle both. I can work for 10 to 15 hours a week on this project, from 05/16 to 08/12. There is no vacation planned during the summer.

Project Description
===================

This project aims to add the complete iconv-based multibyte encoding support to nvi. 

Background
----------
Multibyte encodings are character encodings that use more than one byte to represent a character in the languages. However, when we refer "multibyte" in this article, we mean both single C chars character sets and the wide encodings [3]_. The former one can be either ASCII or 8-bit extended encodings, e.g., ISO8859-15, KOI8-R; the latter one can be either non-Unicode encodings, e.g., GBK, SJIS, or Unicode families. 

A program that "fully supports multibyte encodings" should be able to read/write/display a text file with any encodings supported by libiconv, as them listed by the command ``iconv -l``. 

Requirements
------------

The following requirements for the new nvi should be met when the project is finished:

1. It fully supports multibyte encodings with libiconv, and it can be compiled and run if libiconv is unavailable or disabled.

2. Its encoding settings can be changed though ex commands at the runtime. By default, it obeys the LC_CTYPE setting. The file encoding detection feature needs further discussion.

3. It behaviors in the original nvi `1.79` way. Features that do not relate to editing might be improved.

4. It can be qualified to enter the FreeBSD base system. The code obeys `style(9) <http://www.freebsd.org/cgi/man.cgi?query=style>`_, and the whole software is distributed under a BSD-style license.

Existing Solutions
------------------

There are several vi/nvi forks that support multibyte encodings:

1. nvi-m17n, as editor/nvi-m17n in the ports. It's a multilingual patch to nvi `1.79`, which is the nvi in the nowadays FreeBSD base system. It only supports ISO-8859 families and non-Unicode CJK encodings.

2. nvi-1.85, as editor/nvi-devel in the ports. It's included in the NetBSD base system. This version does not support non-Unicode encodings. And it depends on DB3/4, which makes it impossible for FreeBSD to accept it. In addition, it was reported that it behaviors differently from the traditional vi/nvi.

3. ex-vi, as editor/2bsd-vi in the ports. It's a BSD-licensed, enhanced version of the original vi in SysV [4]_. It supports Unicode and non-Unicode encodings (in a personal rough test). However, as a "traditional vi", it lacks of some nvi-specific features, including infinite undo, multiple buffer, and multiple window, etc. To keep the current user experiences, we have strong reason to keep using nvi. 

4. Other non-compatible forks, such as vim and elvis. We can safely ignore them when talking about the vi in the base system. 

As an initial plan, I can start from nvi's code, analyze nvi-1.85's libiconv usage, study nvi-m17n's encoding detection and encoding switch, then create a new multibyte solution for nvi. 

Testing Plan
------------

The testing will cover at least the following three parts:

1. Wide character display and editing. The new vi program should be able to display and edit wide characters (ncurses functionality, to be more specific). These tests need to be done manually. 

2. Multibyte text processing. The new ex command should be able to match/substitute multibyte text. These tests will use vim as a reference and can be automated with scripts.

3. Portability. The whole software must be able to be built and to run on the FreeBSD branches from RELENG_7 to CURRENT. These tests can be done by hand in `jail(8) <http://www.freebsd.org/cgi/man.cgi?query=jail>`_.

Schedule
--------

 `* This schedule requires further discussion with my mentor.`

1. *5/16-5/27* Read and clean up the nvi-1.79 code. Remove perl and tcl bindings if possible.

2. *5/30-6/03* Construct the ``wchar_t`` and libncursesw framework. Then nvi should work with the raw multibyte data instead of print escaped bytes.

3. *6/06-6/17* Introduce the libiconv support and the basic LC_CTYPE detection. Then nvi should be able to read/write locale-limited text.

4. *6/20-6/24* Run all tests. Prepare a phase report if needed.

5. *6/27-7/08* Design and implement the new encoding-related `ex` commands.

6. *7/11-7/15* Execute the complete testing plan. Now nvi should be able to handle all encodings listed in ``iconv -l``.

7. *7/18-7/29* Port and extend nvi-m17n's file encoding detection infrastructure.

8. *8/01-8/05* Rerun the portability testing. Prepare the final report.

9. *8/08-8/12* Last week. Call for tests in the community.

References
==========

.. [1] Oldroyd, J.R. (2009, April 11). `Unicode Support on FreeBSD`, from http://opal.com/jr/freebsd/unicode/#textutils2
.. [2] Wilke, M. (2011, March 6). `FreeBSD needs fresh Blood!`, from http://miwi.bsdcrew.de/2011/03/freebsd-needs-fresh-blood/
.. [3] Wu, M.C. (2010). Localization - I18N/L10N Usage and Setup. In `FreeBSD Handbook`, http://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/using-localization.html
.. [4] Ritter, G. (2007, November 29). `The Traditional Vi`, at http://ex-vi.sourceforge.net/

:Author: Zhihao Yuan <lichray@gmail.com>
:Date:   2011-04-03

