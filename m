Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264700AbSKDPUw>; Mon, 4 Nov 2002 10:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264701AbSKDPUw>; Mon, 4 Nov 2002 10:20:52 -0500
Received: from mail.hometree.net ([212.34.181.120]:38610 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S264700AbSKDPUs>; Mon, 4 Nov 2002 10:20:48 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [lkcd-general] Re: What's left over.
Date: Mon, 4 Nov 2002 15:27:21 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <aq63kp$9j6$1@forge.intermeta.de>
References: <Pine.LNX.3.96.1021103082813.5197A-100000@gatekeeper.tmr.com> <1036423775.1113.71.camel@irongate.swansea.linux.org.uk>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1036423641 13260 212.34.181.4 (4 Nov 2002 15:27:21 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 4 Nov 2002 15:27:21 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>On Mon, 2002-11-04 at 14:45, Henning P. Schmiedehausen wrote:
>> Good! This means, people debugging the code have actually to think and
>> don't produce "turn on debugger, step here, there, patch a band aid,

>Some of us debug hardware. Regardless of the nice theories about
>reviewing your code they don't actually work on hardware because no
>amount of code review will let you discover things like undocumented 
>2uS deskew delays, or errors in DMA engines

A debugger won't help you here either. A pci bus probe, a 'scope and a
logic analyzer do.

(And experience, elbow grease, experience and a nice amount of ESP :-)
I do hate hardware. Had to debug too much of it (and just on
m68k/MCS-51 where the clock rates are low and the parts easy to
solder...).

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
