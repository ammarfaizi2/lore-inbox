Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbTAEVZO>; Sun, 5 Jan 2003 16:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbTAEVZO>; Sun, 5 Jan 2003 16:25:14 -0500
Received: from mail.hometree.net ([212.34.181.120]:27541 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S265174AbTAEVZN>; Sun, 5 Jan 2003 16:25:13 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Why is Nvidia given GPL'd code to use in non-free drivers?
Date: Sun, 5 Jan 2003 21:33:48 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <ava8bs$gbi$1@forge.intermeta.de>
References: <20030102013736.GA2708@gnuppy.monkey.org> <Pine.LNX.4.44.0301020245080.8691-100000@fogarty.jakma.org> <20030102055859.GA3991@gnuppy.monkey.org> <20030102061430.GA23276@mark.mielke.cc> <E18UIZS-0006Cr-00@fencepost.gnu.org> <20030103075134.GA31357@mark.mielke.cc> <E18UYSe-0004v1-00@fencepost.gnu.org> <20030104011926.GB4472@mark.mielke.cc>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1041802428 24588 212.34.181.4 (5 Jan 2003 21:33:48 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sun, 5 Jan 2003 21:33:48 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke <mark@mark.mielke.cc> writes:

>I have the freedom to use Linux and ClearCase. If closed source modules
>were to be disallowed, it would be illegal for me to use this configuration,
>and I would be forced to use HP-UX or Solaris, and not Linux.

No, it wouldn't. Thats' what most people don't understand. You
wouldn't have a license to GIVE AWAY a system which consists of Linux
kernel and MVFS object module.

You definitely have a license to get a Linux system, install it, run
it and install on it every piece of software you like. If you install
MVFS, there is nothing in the GPL to prevent you from this. Neither in
the GPL nor in the Linux-modified version of "you may load binary
modules" GPL. This is your personal decision of your personal
system. If you install a module that is binary only, fine.

GPL is about SOFTWARE DISTRIBUTION. Not about SOFTWARE USAGE. I know
(and I read this in many of his postings) that RMS likes to blur this
point into "if it is not free, you must not use it with GPL software",
but this is simply _NOT TRUE_. It is your personal freedom to choose
and use a binary module. If you redistribute it, you may take freedom
from the recipient away and this prohibits the GPL. But not your
personal usage.

Sheesh. I have lots of kernel modules in current use which will never
be released outside the scope of my own boxes. That's no breach of the
GPL. You'll never be able to acquire either a source or a binary code
license. This is my code. You cannot have it. My freedom to decide so. 
End of story.

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
