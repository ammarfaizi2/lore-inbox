Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155518AbQD2A1k>; Fri, 28 Apr 2000 20:27:40 -0400
Received: by vger.rutgers.edu id <S155511AbQD2A1T>; Fri, 28 Apr 2000 20:27:19 -0400
Received: from orzan.fi.udc.es ([193.144.60.19]:54190 "EHLO orzan.fi.udc.es") by vger.rutgers.edu with ESMTP id <S155399AbQD2A1E>; Fri, 28 Apr 2000 20:27:04 -0400
To: linux-kernel@vger.rutgers.edu
Subject: Memtest suite v0.0.3
X-Url: http://carpanta.dc.fi.udc.es/~quintela
From: "Juan J. Quintela" <quintela@fi.udc.es>
Date: 29 Apr 2000 02:25:11 +0200
Message-ID: <yttr9bpbvo8.fsf@vexeta.dc.fi.udc.es>
Content-Type: text/plain; charset=us-ascii
User-Agent: Gnus/5.0804 (Gnus v5.8.4) Emacs/20.5
MIME-Version: 1.0
Sender: owner-linux-kernel@vger.rutgers.edu


Hi
        new version of memtest suite.  If you have any more tests they
        are welcome.

Later, Juan.

Memory test suite v0.0.3
------------------------

This intends to be a set of programs to test the memory management
system.  I am releasing this version with the idea of gather more
programs for the suite.  If you have some program to test the system,
please send it to me (quintela@fi.udc.es).

If you found values/combinations of tests for what the system
crash/Oops/whatever please report it to me.  Then I can include it in
the tests and the people who tune the MM system can test it next time.

This version has:
        An improved README
        new shm test
        removing several compilations warnings
        added Tests file

Any comments/suggestions/code are welcome.

Note:  I am not a C++ programmer, if somebody knows how to remove the
       warnings in the c++ test (shm-stresser) I will be grateful.


Thanks for your time,
        Juan Quintela
        quintela@fi.udc.es

The home of this package is:

http://carpanta.dc.fi.udc.es/~quintela/memtest/


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
