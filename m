Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313684AbSDPODx>; Tue, 16 Apr 2002 10:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313686AbSDPODw>; Tue, 16 Apr 2002 10:03:52 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:38408 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313684AbSDPODv>; Tue, 16 Apr 2002 10:03:51 -0400
Date: Tue, 16 Apr 2002 10:00:36 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
In-Reply-To: <20020416013016.GA23513@matchmail.com>
Message-ID: <Pine.LNX.3.96.1020416095729.26684A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2002, Mike Fedyk wrote:

> No matter how much someone can go through their own code and say "it's
> ready" there's always a good chance there is some bug that will trigger
> under testing.  Also, Andrew found a problem with your locking changes when
> he split up your patch, and at the time you were saying it is ready and
> there were no bug reports against in...

If you are going to reject code from people who send in code which turns
out to have bugs you are going to have a VERY small set of submitters.
It's good to have someone else read the code, for breakup or whatever, but
to avoid cleanup in a stable kernel seems long term the wrong direction.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

