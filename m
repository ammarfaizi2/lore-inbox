Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130788AbQKKNuy>; Sat, 11 Nov 2000 08:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130648AbQKKNun>; Sat, 11 Nov 2000 08:50:43 -0500
Received: from limes.hometree.net ([194.231.17.49]:26912 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S130785AbQKKNua>; Sat, 11 Nov 2000 08:50:30 -0500
To: linux-kernel@vger.kernel.org
Date: Sat, 11 Nov 2000 13:45:38 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <8ujii2$1st$1@forge.tanstaafl.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <3A0C7139.DDD81E67@timpanogas.org>, <Pine.LNX.4.30.0011101719440.19584-100000@back40.badlands.lexington.ibm.com>
Reply-To: hps@tanstaafl.de
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cowboy@vnet.ibm.com (Richard A Nelson) writes:

>I have several boxen running sendmail with fair to moderate loading -
>they even occasionally don't accept mail... and thats good, as it lets
>the system catch up with its current load.  As soon as things stabalize,
>sendmail again accepts connections - you *do* have MX entries don't you?

% dig timpanogas.com mx
[...]
timpanogas.com.         1D IN MX        10 mail.timpanogas.com.


No. He _is_ clueless with a big mouth as the regular readers of LKM
already know.

"and it's all either the fault of other people or the kernel". 

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
