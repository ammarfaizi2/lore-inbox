Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbSLLLFC>; Thu, 12 Dec 2002 06:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262464AbSLLLFC>; Thu, 12 Dec 2002 06:05:02 -0500
Received: from mail.hometree.net ([212.34.181.120]:55256 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S262457AbSLLLFA>; Thu, 12 Dec 2002 06:05:00 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Is this going to be true ?
Date: Thu, 12 Dec 2002 11:12:47 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <at9qvf$ds4$1@forge.intermeta.de>
References: <001801c2a0a9$02613f40$2e863841@joe> <yw1xvg1zfspi.fsf@tophat.e.kth.se>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1039691567 3712 212.34.181.4 (12 Dec 2002 11:12:47 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 12 Dec 2002 11:12:47 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=) writes:

>> comparing unices and Windoze, is the question "What is an operating
>> system"? Is the kernel the OS? Are the libraries part of it as well?

>IMHO, the operating system is whatever is reached through system
>calls, i.e traps.  MS seems to define it as whatever they bundle on
>the CD.

99,95+% of the computer users base out there tend to differ. This
makes your point rather moot :-) (To me, the "OS" consists at least of
the kernel, c standard library/ies with their support files and enough
infrastructure to start programs without having to hard code them on a
kernel boot line or in code. Which is at least /sbin/init and might
even contain a simple user command shell).

This definition could fit on a floppy, though. Might even fit on an
720k diskette. :-) Kernel + /sbin/init + busybox is IMHO an OS.

If you define "OS" at the syscall layer you end up with what we
started.  Two threads printing 1 0 1 0 1 0 on your screen.

	Regards
		henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
