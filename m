Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261348AbSIPLLw>; Mon, 16 Sep 2002 07:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261350AbSIPLLw>; Mon, 16 Sep 2002 07:11:52 -0400
Received: from mail.hometree.net ([212.34.181.120]:3265 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S261348AbSIPLLv>; Mon, 16 Sep 2002 07:11:51 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Date: Mon, 16 Sep 2002 11:16:49 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <am4ej1$9sr$1@forge.intermeta.de>
References: <Pine.LNX.4.44.0209101156510.7106-100000@home.transmeta.com> <E17qRfU-0001qz-00@starship> <20020915020739.A22101@devserv.devel.redhat.com> <200209160236.g8G2a6Qn022070@pimout3-ext.prodigy.net> <20020915200002.B23345@work.bitmover.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1032175009 439 212.34.181.4 (16 Sep 2002 11:16:49 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 16 Sep 2002 11:16:49 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

>It's a sign of a naive programmer when you hear "this code is all shit"
>and it's useful code.  That means the programmer would rather rewrite
>working code than understand it enough to fix it.  Extremely common.
>And extremely wrong in almost all cases.  It's *hard* to understand code.
>Get over it.  Read the code, think, read again, think some more, keep
>it up.  Always always always assume the guy who came before you *did*
>know what they were doing.  Otherwise all you do is replace mostly working
>code with brand new code that works for the *one* case in front of the
>new programmer and none of the 100's of cases that the old code handled.

Once again. BS. 99% of the cases where I had to work on foreign code,
it was a codebase where someone with a clue wrote something nice, and
then lots of people without clue "improved" that code. Then I start to
work on it and have to clean up the mess. First thing is that you want
to everytime is, to _understand_ what the original author wanted to do
with the code and what the clueless did to this idea. A debugger is a
decent toy for this. commons-logging another.

Code which was written like you describe is never hard to
understand. Clueful people know that they have to comment their
"tricks".

Ask me about Bean-Setters with a return value. Now that's clever. =:-(

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
