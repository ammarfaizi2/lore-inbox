Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130839AbQKKNuw>; Sat, 11 Nov 2000 08:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130785AbQKKNuo>; Sat, 11 Nov 2000 08:50:44 -0500
Received: from limes.hometree.net ([194.231.17.49]:26912 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S130788AbQKKNub>; Sat, 11 Nov 2000 08:50:31 -0500
To: linux-kernel@vger.kernel.org
Date: Sat, 11 Nov 2000 13:35:26 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <8ujhuu$1qu$1@forge.tanstaafl.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <jmerkey@timpanogas.org>, <20001111123325.A17600@uni-mainz.de>
Reply-To: hps@tanstaafl.de
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in /var/spool/mqueue]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dominik.kubla@uni-mainz.de (Dominik Kubla) writes:

>I can do better! I had a smart ass trying to backup his harddrives
>using email, no less than 2Gig!

So what? Get enough spool space in /var/spool/mqueue and a platform
with 64 bit file support and it works just fine. I have some boxes
where the users send 100+ MByte mails on a regular base. Once you beat
the procmail into submission, this simply works.

sendmail is one of the very best pieces of free multi-platform
software that is available. I really admire the people that wrote
it. Kudos to everyone that wrote on this software. All hail Eric
Allman. ;-)

It is mean, tough, hard to understand and configure but definitely
industrial strength, proven and reliable. Something you can't say of
all this sissy "free" software around today.

And once you get a hang of "left side, right side" rules, you can read
sendmail.cf like normal text. The idea of using an algorithmic concept
for a config file still shines after twenty years of development. So
much for "GUIs".

	sendmail rocks
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
