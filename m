Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265390AbSJXLDa>; Thu, 24 Oct 2002 07:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265392AbSJXLDa>; Thu, 24 Oct 2002 07:03:30 -0400
Received: from mail.hometree.net ([212.34.181.120]:16073 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S265390AbSJXLDa>; Thu, 24 Oct 2002 07:03:30 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: One for the Security Guru's
Date: Thu, 24 Oct 2002 11:09:41 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <ap8kdl$bae$1@forge.intermeta.de>
References: <20021023130251.GF25422@rdlg.net> <1035411315.5377.8.camel@god.stev.org> <20021024101126.GQ147946@niksula.cs.hut.fi>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1035457781 18587 212.34.181.4 (24 Oct 2002 11:09:41 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 24 Oct 2002 11:09:41 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva <vherva@niksula.hut.fi> writes:

>the /dev/kmem hole, but this closes 2 classes of attacks - loading rootkit
>module and booting with a hacked kernel in straight-forward way.

Question: What do I lose when you remove /dev/kmem?
Related question: Would it be useful to make /dev/kmem read-only? 

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
