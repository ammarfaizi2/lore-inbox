Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRAJVsV>; Wed, 10 Jan 2001 16:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136730AbRAJVrx>; Wed, 10 Jan 2001 16:47:53 -0500
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:51467 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S129610AbRAJVrf>; Wed, 10 Jan 2001 16:47:35 -0500
Date: Wed, 10 Jan 2001 13:47:18 -0800 (PST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Matthias Juchem <juchem@uni-mannheim.de>
cc: <linux-kernel@vger.kernel.org>, Keith Owens <kaos@ocs.com.au>,
        Ulrich Drepper <drepper@redhat.com>
Subject: Re: bugreporting script - second try
In-Reply-To: <Pine.LNX.4.30.0101102128500.12979-101000@gandalf.math.uni-mannheim.de>
Message-ID: <Pine.LNX.4.30.0101101340460.14855-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Matthias ,  When I run your script under a -very- old
	release of slackare (See after .sig) I get the below .
	my ldd is ancient .

root@filesrv1:~# ~/bin/bugreport.sh asdfasdfasdf
/usr/local/sbin:/usr/sbin:/sbin:/root/bin:/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:/usr/openwin/bin:/usr/games:/opt/schily/bin:/etc/rc.d/init.d:/sbin:/usr/sbin

bugreport.sh - Linux Kernel Problem Report Generator v0.3
=========================================================
       written by Matthias Juchem <matthias@brightice.de>

Directory with kernel sources  [/usr/src/linux]:
dirname /usr/i386-slackware-linux-gnulibc1/lib/libc.so.5
/root/bin/bugreport.sh: [: too many arguments
ls: /usr/lib/libg++.so.*: No such file or directory
ldd: invalid option -- -
ldd: invalid option -- e
ldd: invalid option -- s
ldd: invalid option -- i
ldd: invalid option -- o
ldd: invalid option -- n
/root/bin/bugreport.sh: $4: unbound variable

       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+
-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Slackware-7.0.0
Linux filesrv1 2.2.18pre15 #1 Sat Oct 14 15:58:46 PDT 2000 i686 unknown
Kernel modules         2.1.121
Gnu C                  egcs-2.91.66
Binutils               2.9.1.0.25
Make version           3.77
Linux C Library 6 -    libc-2.1.2
Dynamic Linker (ld.so) 1.9.9
Linux C++ Library      Notfound
Procps                 2.0.2
Mount                  2.9v
Net-tools              1.57
Sh-utils               1.16
Flex                   2.5.4
E2fsprogs              1.15

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
