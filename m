Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314889AbSEYQmx>; Sat, 25 May 2002 12:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314961AbSEYQmw>; Sat, 25 May 2002 12:42:52 -0400
Received: from relay04.valueweb.net ([216.219.253.238]:26130 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S314889AbSEYQmv>; Sat, 25 May 2002 12:42:51 -0400
Message-ID: <3CEFBEA3.71611EDB@opersys.com>
Date: Sat, 25 May 2002 12:41:07 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Thunder from the hill <thunder@ngforever.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <20020524223950.D22643@work.bitmover.com> <Pine.LNX.4.44.0205250152110.15928-100000@hawkeye.luckynet.adm> <20020525091444.H28795@work.bitmover.com> <3CEFB9C6.FC21D7CB@opersys.com> <20020525092557.K28795@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Larry McVoy wrote:
> > You can dimiss those who haven't chosen #4 as much as you want and
> > find all the reasons to justify your dismissal. It remains that the
> > embedded/rt market is closed to Linux because of the current situation.
> 
> Hmm, then why did Lineo license the patent?   Why is FSMlabs still in
> business?

I'm not denying that there are clients who will still choose to pay
FSMLabs. But they're a staff of less than 10, so that's not very indicative
of anything else than minor market interest for the technology.

As for Lineo, they've been in financial trouble for some time, so their
situation is rather telling.

> I don't buy your assertions for one second without some strong data to
> back them up.  Just saying something doesn't make it so, show me the
> data.

Developers will simply not come out in the cold and say we chose OS xyz
instead of Linux because of the rtlinux issues. But talk to them in
private and then you get an entirely different picture.

One sympton of the current situation is the recent study by the VDC
which I alluded to earlier:
http://www.linuxdevices.com/articles/AT6328992055.html

When asked what the #1 factor inhibiting the use of Linux, developers
answered "real-time limitations".

This speaks for itself.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
