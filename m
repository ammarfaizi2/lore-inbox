Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbSLBWYh>; Mon, 2 Dec 2002 17:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbSLBWYh>; Mon, 2 Dec 2002 17:24:37 -0500
Received: from mail.hometree.net ([212.34.181.120]:53198 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S265096AbSLBWYc>; Mon, 2 Dec 2002 17:24:32 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: LM sensors into kernel?
Date: Mon, 2 Dec 2002 22:31:59 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <asgn0v$tm$1@forge.intermeta.de>
References: <200212021842.gB2Igou00740@devserv.devel.redhat.com> <Pine.LNX.3.96.1021202140938.433H-100000@gatekeeper.tmr.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1038868319 3574 212.34.181.4 (2 Dec 2002 22:31:59 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 2 Dec 2002 22:31:59 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

>Okay, thanks. I was hoping since lm_sensors were proposed before the
>freeze, relatively stable, and highly useful that they might get in.

As most of the I2C code is in, I would consider the lm_sensors mainly
as "drivers" so they wouldn't be hit by the freeze. 

If you want it in, lobby it with Linus. I'm sure that he is open to
reason (Hah! :-) ).

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
