Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312248AbSC2WpV>; Fri, 29 Mar 2002 17:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312256AbSC2WpL>; Fri, 29 Mar 2002 17:45:11 -0500
Received: from tangens.hometree.net ([212.34.181.34]:28044 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S312238AbSC2Woz>; Fri, 29 Mar 2002 17:44:55 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: bkbits.net down
Date: Fri, 29 Mar 2002 22:44:54 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <a82qp6$ps3$1@forge.intermeta.de>
In-Reply-To: <200203271853.g2RIrRv11812@work.bitmover.com> <20020327222738.B16149@work.bitmover.com> <20020328112252.F22352@work.bitmover.com> <a81gte$hrj$1@forge.intermeta.de> <20020329111833.B6490@work.bitmover.com>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1017441894 15014 212.34.181.4 (29 Mar 2002 22:44:54 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Fri, 29 Mar 2002 22:44:54 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

>things back together for kernel developers.  What, exactly, did you
>hope to accomplish?

Awareness on your side that there are people presenting valid
arguments to you even if you don't agree. I did read the first posts
of the thread up until it degraded to "our application does every
integrity check possible to verify that the data is correct. So even
if it gets corrupted, we will know. That's why we better than the
rest" and you shot down everyone presenting you with other solutions
with this arguments. Well, in this case, you obviously knew that the
data is incorrect (because the disk died, I'm really feeling with you
here, from my eight IBM DTLA disks, three have died, too and I fear
that the remaining five will also die [1]) but all your checks
couldn't help you where just a few up-to-date backups would have.

Actually I'm a bit disappointed too, that you with all the
professionalism that you sprikle over this mailing list in every of
your posts, run such a showcase part of your business as bkbits.net on
IDE disks without RAID. And without clustering in case of emergency.

	Regards
		Henning


[1] I keep them in an dust free, climate controlled environment (18
degree centigrade all the time) and they're continously running (no
on-off operations) and they still die. IBM really deserves to suffer
for these disks. The last two died within six hours in the same box
after 20 months of continous running [2].

[2] I had the system up and running again 93 minutes after I pulled it
from the rack. Amanda and daily backups saved my ass. :-) And my
applications do not do integrity checks.

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
