Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264373AbRFGKDf>; Thu, 7 Jun 2001 06:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262406AbRFGKD0>; Thu, 7 Jun 2001 06:03:26 -0400
Received: from tangens.hometree.net ([212.34.181.34]:6351 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S262400AbRFGKDQ>; Thu, 7 Jun 2001 06:03:16 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
Date: Thu, 7 Jun 2001 10:03:12 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9fnjh0$d1c$1@forge.intermeta.de>
In-Reply-To: <200106051659.LAA20094@em.cig.mot.com> <15134.49211.159673.522020@pizda.ninka.net>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 991908192 4191 212.34.181.4 (7 Jun 2001 10:03:12 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Thu, 7 Jun 2001 10:03:12 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

>And my current understanding is that allowing proprietary
>reimplementations of the VM, VFS, and core networking, is not one of
>the things which is allowed.

...is wanted (by you and possibly Linus). Not ...is allowed. 
 
It _is_ already allowed. Someone can use the posted patch which is GPL
open source, put it into the kernel and use their proprietary module.

And this is legal according to the "Kernel GPL, Linus Torvalds edition
(TM)" which says "any loadable module can be binary only". Not "only
loadable modules which are drivers". It may not be the intention but
it is the fact.

The cat is already out of the box. Ok, someone will have to maintain
the small glue patch separate from the kernel but you're already
screwed. You, as a nay-sayer, just make work a little harder for some
of the really useful uses of such an addition and life a little easier
for companies that supply such a feature with their OS and say that
Linux, oops, DaveM stifles and hinders inovation because of ego. And
that a "shared source" model avoids single persons jumping up and down
until they're blue in their face to block others. And that their code
base will not fork over such a minor issue.

And all this is still a part of "freedom".

	Regards
		Henning

[ I consider your position a good and valid one from a "pure" view and
I really like it. But reality is different. And you should _work_ with
the people, and help them to keep their stuff in the open source and
not insult them. ]

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
