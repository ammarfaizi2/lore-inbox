Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSGUXBc>; Sun, 21 Jul 2002 19:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSGUXBc>; Sun, 21 Jul 2002 19:01:32 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:38596 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S315200AbSGUXBb>; Sun, 21 Jul 2002 19:01:31 -0400
Date: Mon, 22 Jul 2002 01:04:25 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Mike Galbraith <efault@gmx.de>
cc: Tomas Szepe <szepe@pinerecords.com>,
       Thunder from the hill <thunder@ngforever.de>,
       Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Give Bartlomiej a break!  (Re: Impressions of IDE 98?)
Message-ID: <Pine.SOL.4.30.0207220032410.15795-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 21 Jul 2002, Mike Galbraith wrote:

>> Well you don't necessarily have to be an IDE guru to realize something's
>> wrong when you see a bloke constantly breaking the subsystem, practically
>> never fixing it up himself, disappearing for a month w/o saying a word
>> after having fried 2.5.25 completely and not really caring about what
>> others have to say about the code.

> No, you don't have to be a guru to notice that the rewrite is proving
> difficult.

You also don't have to be a guru to notice that recently most of the
content of the rewrite is moving code here and there, unfolding functions,
renaming them and changing intendation. Check yourself.
Also imagine how hard is now to track changes from 2.4 to 2.5
now and fix bugs.

Yup, please give me a break from having to track this changes. :-)

If you go through all the ide-clean patches you will see that much
of the cruft has been removed, some things fixed but there is still
plenty of work to do.

Next problem is that Martin seems to not care that his style of
development (pushing stuff immediately to Linus instead of lkml -> some
reasonable delay -> Linus) _constantly_ interferes other people doing
kernel hacking.

I don't want next flamewar or personal bashing here,
please only _think_ for a while about issues raised.

Regards
--
Bartlomiej

