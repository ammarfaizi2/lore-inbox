Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSEYH7h>; Sat, 25 May 2002 03:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314082AbSEYH7g>; Sat, 25 May 2002 03:59:36 -0400
Received: from pD9E23A41.dip.t-dialin.net ([217.226.58.65]:48793 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314078AbSEYH7g>; Sat, 25 May 2002 03:59:36 -0400
Date: Sat, 25 May 2002 01:59:10 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Larry McVoy <lm@bitmover.com>
cc: Karim Yaghmour <karim@opersys.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <20020524223950.D22643@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0205250152110.15928-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 24 May 2002, Larry McVoy wrote:
> Then you have absolutely no beef with the FSMlabs patent.  Let's review:
> 
>     a) you get to use it if the stuff built on it, all of it, is GPLed.
>     b) you build on GPLed stuff.
> 
> Seems like you either have no problem or you aren't disclosing the whole
> story.  I really don't understand why there is a problem here.   100%
> GPLed is OK, so why do you have a problem?

I think the point he's tryin' to make is somewhere else than that. There 
are lots of companies running embedded devices (oh yes, I can tell ;-), 
and as long as it is a) not clear and/or b) impossible by license to use 
real time linux w/their licenses, they won't.

Embedded and real time devices are "The Future" for lots of companies. And 
of course they're going to want to sell it. Currently, they have three 
ways:

1. They try RTAI and don't have any licensing problems, but they are very 
   unsure about it, since certain people keep telling that RTAI is crap

2. They get used to RTLinux, where they are altogether forced to use 
   either GPL or their license. This isn't exactly a way of choice.

3. They go buy another real time os implementation.

Most will decide for 3., since it's the easy and virtually obvious way. 
Thus, Linux isn't going to get very far in respect to embedded devices. I 
suppose _THAT'S_ the point he was trying to make.

Regards,
Thunder
-- 
Was it a black who passed along in the sand?
Was it a white who left his footprints?
Was it an african? An indian?
Sand says, 'twas human.

