Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbSKNX3j>; Thu, 14 Nov 2002 18:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265320AbSKNX3j>; Thu, 14 Nov 2002 18:29:39 -0500
Received: from mail.hometree.net ([212.34.181.120]:6092 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S262813AbSKNX3j>; Thu, 14 Nov 2002 18:29:39 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: system lockups and shutdowns fo running processes
Date: Thu, 14 Nov 2002 23:36:32 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <ar1c20$jvr$1@forge.intermeta.de>
References: <20021114180807.20f1578f.tmika@t-online.de> <Pine.LNX.3.95.1021114132125.13043A-100000@chaos.analogic.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1037316992 7805 212.34.181.4 (14 Nov 2002 23:36:32 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 14 Nov 2002 23:36:32 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

>> Call Trace: [<c012f5b4>] [<c0131c47>] [<c0131eb5>] [<c010546c>]
>> Code: 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20 07 20
>> 

>Yawn.  It's trying to execute data...
><TAB><SPC><TAB><SPC><TAB><SPC>..........
>Possible stack overflow.

<TAB> = ^I = 09

07 = ^G = <BEL>

	Regards
		Henning


-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
