Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265076AbSJWQUo>; Wed, 23 Oct 2002 12:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbSJWQUn>; Wed, 23 Oct 2002 12:20:43 -0400
Received: from mail.hometree.net ([212.34.181.120]:30890 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S265076AbSJWQUm>; Wed, 23 Oct 2002 12:20:42 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: feature request - why not make netif_rx() a pointer?
Date: Wed, 23 Oct 2002 16:26:52 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <ap6ikc$1qc$1@forge.intermeta.de>
References: <00b201c27a0e$3f82c220$800a140a@SLNW2K> <1035389494.3968.63.camel@irongate.swansea.linux.org.uk>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1035390412 8059 212.34.181.4 (23 Oct 2002 16:26:52 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 23 Oct 2002 16:26:52 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> Not putting an export into the source or exporting GPL_ONLY symbols
>> won't hinder anyone. Because putting the hooks into a GPL source and
>> then releasing the result (code + hooks) under GPL is perfectly legal.

>Not according to lawyers

"The kernel source code + hooks under GPL" definitely are.

"The kernel source code + hooks + binary modules" are doubtful, correct.

Sorry, my wording wasn't clear.

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
