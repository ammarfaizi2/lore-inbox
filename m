Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130792AbQKKNun>; Sat, 11 Nov 2000 08:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130648AbQKKNuc>; Sat, 11 Nov 2000 08:50:32 -0500
Received: from limes.hometree.net ([194.231.17.49]:26912 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S130760AbQKKNu2>; Sat, 11 Nov 2000 08:50:28 -0500
To: linux-kernel@vger.kernel.org
Date: Sat, 11 Nov 2000 13:24:18 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <8ujha2$1ou$1@forge.tanstaafl.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <Pine.LNX.3.95.1001110142537.5403A-100000@chaos.analogic.com>, <3A0C4D6B.B4FF664C@timpanogas.org>
Reply-To: hps@tanstaafl.de
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in /var/spool/mqueue]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey@timpanogas.org (Jeff V. Merkey) writes:

>I did Dick.  The config is fine.  The daemon is also fine and running. 
>What's really weird is that even if I do a "sendmail -v -q" command
>(which should force the queue to flush) it still doesn't. 

O Timeout.ident=0s
O Timeout.initial=30s (these are the ninieties / 21st century)

Get someone that really has an idea about sendmail. 

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
