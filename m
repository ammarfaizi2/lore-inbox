Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267370AbSLKXjx>; Wed, 11 Dec 2002 18:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267371AbSLKXjx>; Wed, 11 Dec 2002 18:39:53 -0500
Received: from mail.hometree.net ([212.34.181.120]:45257 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S267370AbSLKXjv>; Wed, 11 Dec 2002 18:39:51 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Is this going to be true ?
Date: Wed, 11 Dec 2002 23:47:38 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <at8iqq$n4n$1@forge.intermeta.de>
References: <Pine.LNX.4.50.0212102157440.1634-100000@ddx.a2000.nu> <050c01c2a091$77564600$9c094d8e@wcom.ca> <3DF66754.3020901@WirelessNetworksInc.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1039650458 10232 212.34.181.4 (11 Dec 2002 23:47:38 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 11 Dec 2002 23:47:38 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herman Oosthuysen <Herman@WirelessNetworksInc.com> writes:

>kind of BSD, so to release a Linux version of MS Office and other 
>utilities, would be very easy for them as they just need to recompile 
>the Apple versions.

BS. Mac OS X does not use the X11 window system. That's where the fun lies.
If a company decides to release an application for Linux they will either
rewrite it using Motif (ugh) or use a modern window tool kit like GTK or
QT. Or even (horrors) use some sort of Windows Compatibility Library like
WINE or WxWindows. 

But you can't compile a MacOS X application on Linux. You're missing all of
the necessary display libraries and infrastructure.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
