Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSEXV3G>; Fri, 24 May 2002 17:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSEXV3F>; Fri, 24 May 2002 17:29:05 -0400
Received: from relay02.valueweb.net ([216.219.253.236]:41481 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S311749AbSEXV3E>; Fri, 24 May 2002 17:29:04 -0400
Message-ID: <3CEEAE3D.EB64A3AA@opersys.com>
Date: Fri, 24 May 2002 17:18:53 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@e-mind.com>
CC: Dan Kegel <dank@kegel.com>, Andrew Morton <akpm@zip.com.au>,
        Hugh Dickins <hugh@veritas.com>, Christoph Rohland <cr@sap.com>,
        Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <Pine.LNX.4.21.0204292127480.1709-100000@localhost.localdomain> <3CEDF94C.592636A6@kegel.com> <3CEDFCED.D10CD618@zip.com.au> <3CEE806D.D52FBEA5@kegel.com> <20020524202658.GI15703@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just wanting to put the record straight here about the rtlinux patent.

Andrea Arcangeli wrote:
> risk a fragmentation. Until it was only rtlinux to be patented that is
> never been a showstopper because real time apps are a niche market and
> they're not mainstream

I've been involved in fighting this patent for the last 2 years. During
this time, I have met and talked with many people about this issue. Today,
I can assure you that the rtlinux patent is definitely a show-stopper for
Linux.

As it stands now, Linux will never be a viable embedded OS until someone
gets rid of the rtlinux patent. As a matter of fact, many people in the
industry decide to go with WinCE precisely because of the rtlinux patent.

Many in the real-time Linux community are very worried by the fact that
the kernel developers do indeed see real-time as a niche market because
the members of the real-time Linux community see the damage being done to
Linux's penetration in the embedded field because of the patent.

As the latest VDC report indicates
(http://www.linuxdevices.com/articles/AT6328992055.html), the no. 1
factor inhibiting Linux's adoption as an embedded OS is indeed real-time.

It is no wonder that the established embedded vendors (WindRiver, QNX,
etc.) feel no threat from Linux. They know that every time Linux will
be evaluated, it will be put aside because of the patent.

Given that the embedded field is poised to overtake the desktop and the
server in terms of number of devices deployed, it would seem to me
that this is much more than just a niche market.

Until the rtlinux patent is dismissed, Linux will remain on the fringes
of the real-time and embedded application field. Unfortunately.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
