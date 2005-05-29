Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVE2VSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVE2VSR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 17:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVE2VSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 17:18:17 -0400
Received: from h80ad2702.async.vt.edu ([128.173.39.2]:38149 "EHLO
	h80ad2702.async.vt.edu") by vger.kernel.org with ESMTP
	id S261446AbVE2VSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 17:18:04 -0400
Message-Id: <200505292116.j4TLGpow016441@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Bill Huey <bhuey@lnxw.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance 
In-Reply-To: Your message of "Sun, 29 May 2005 13:52:45 MDT."
             <Pine.LNX.4.61.0505291223120.12903@montezuma.fsmlabs.com> 
From: Valdis.Kletnieks@vt.edu
References: <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <Pine.LNX.4.61.0505281953570.12903@montezuma.fsmlabs.com> <1117334933.11397.21.camel@mindpipe> <Pine.LNX.4.61.0505282054540.12903@montezuma.fsmlabs.com> <200505290408.j4T487n6024489@turing-police.cc.vt.edu> <Pine.LNX.4.61.0505290856220.12903@montezuma.fsmlabs.com> <200505291750.j4THoUWW010374@turing-police.cc.vt.edu>
            <Pine.LNX.4.61.0505291223120.12903@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1117401410_6734P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 29 May 2005 17:16:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1117401410_6734P
Content-Type: text/plain; charset=us-ascii

On Sun, 29 May 2005 13:52:45 MDT, Zwane Mwaikambo said:

> i originally stated was that media applications are not common place as far 
> as _hard_ realtime systems are concerned, this was in reply to Bill's 
> emphasis on media applications.

Only because the average factory can afford the current "hard RT" gear, and
the average musician can't.

So the end result is that the factory doesn't have to pay for another part
ruined because a hole is drilled in the wrong place if the "hard RT" misses,
and the musician just has to resign themselves to "OK, let's try *another* take
and hope there's no POPs in it this time.." - even if the "hard RT" only ruins
a $5 part that you're making thousand a day, while the next take of the
musicians may cost a lot more than $5, and you don't get thousands of takes a
day.

At that point, the musician is cursing that he doesn't have "hard RT"....

(Of course, the musician doesn't *really* need a *totally* "hard RT" guarantee -
it would probably be quite sufficient if he lost only one take or two a month.
This is the sort of place where a "98% for 10% the cost" can win big...)

Yes, there's probably lots of *other* applications that would be written if
hard RT was available cheaply - but audio/video are a *known* area already.

> Terribly sorry old bean, but Linux isn't the center of the universe. I'm 
> afraid Linux wasn't the push factor which led to the proliferation of 
> multiprocessor systems.

Linux was *one* factor - the *point* was that we're seeing lots of things that
use clusters and massive parallelism that we *didnt* see when clusters weren't
financially feasible for many.  So looking around the SMP landscape 7-10 years
ago, you'd have found only a few large sites doing it, and you would have said
"But people are doing A, B, and C on clusters, and almost nobody's doing X, Y
and Z on clusters" (pick any 3 X Y Z that have gotten big growth since).





--==_Exmh_1117401410_6734P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCmjFCcC3lWbTT17ARAp8uAKCiFyXoZqNNIaHSou20qPnA1QovBgCgvNzv
k9E2+vUdnHJ8CRYjc3wF2UM=
=bVDO
-----END PGP SIGNATURE-----

--==_Exmh_1117401410_6734P--
