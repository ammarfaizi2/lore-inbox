Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131296AbQIGTye>; Thu, 7 Sep 2000 15:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131289AbQIGTyY>; Thu, 7 Sep 2000 15:54:24 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:16960 "EHLO penguin.e-mind.com") by vger.kernel.org with ESMTP id <S131269AbQIGTyL>; Thu, 7 Sep 2000 15:54:11 -0400
Date: Thu, 7 Sep 2000 21:52:15 +0200 (CEST)
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel Debugging Documentation
Message-ID: <Pine.LNX.4.21.0009072129030.10387-100000@inspiron.random>
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back in May I wrote a quite estensive documentation about all the
possible/best ways to debug the Linux Kernel for a talk/tranining that I
did in San Jose in May. I find now the time to clean it up and to upload
since I think it could result useful to everybody dealing with kernel
developement.

	ftp://ftp.suse.com/pub/people/andrea/talks/english/2000/kdebug-may-2000-20000907.tar.gz

It addresses
MCORE/LKCD/KDB/KGDB/NMI-watchdog/TRACER/IKD/PRINTK/BUG/OOPS/KMSGDUMP and
many other issues (simptom/realbug as well).

They were the digital slides for the talk, so while writing them I
expected to ingegrate them with speach, but they should be readable also
standalone.

They're written in MGP (MagiPoint, not that I like it too much but
kpresenter wasn't that powerful at that time). A postscript is included
into the tarball as well (they should be easily readable with `gv` with
antialiasing enabled).

I'd say it's a _must_ read for any kernel developer (feel free to announce
it on other places as well if you think it's good idea of course).

Hope you find them useful, have fun.

Andrea

PS. If you have patches for the document send them to me and I'll
    integrate them. Kurt just sent me a 1000 lines patch to
    correct my english errors in the original version :))

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
