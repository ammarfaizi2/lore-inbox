Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282885AbRK0JFP>; Tue, 27 Nov 2001 04:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282883AbRK0JFG>; Tue, 27 Nov 2001 04:05:06 -0500
Received: from tangens.hometree.net ([212.34.181.34]:21455 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S282881AbRK0JEy>; Tue, 27 Nov 2001 04:04:54 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: Possible md bug in 2.4.16-pre1
Date: Tue, 27 Nov 2001 09:04:52 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9tvkvk$101$1@forge.intermeta.de>
In-Reply-To: <000c01c1769c$187cc390$9865fea9@pcsn630778> <200111261929.UAA31258@nbd.it.uc3m.es>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1006851892 24732 212.34.181.4 (27 Nov 2001 09:04:52 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 27 Nov 2001 09:04:52 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" <ptb@it.uc3m.es> writes:

>Raid has been in quite a shocking state for a long while and
>often there seems nor rhyme nor reason to its behaviour. If you want
>to stick your machine in an endless loop, just try initialising a
>mirror raid device with only one of its two components currently
>working. 

Hm, what? That's my standard migration path from non-mirrored to
mirrored under 2.2.x You say, that this is not possible under 2.4?

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
