Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316548AbSHGXqi>; Wed, 7 Aug 2002 19:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316649AbSHGXqi>; Wed, 7 Aug 2002 19:46:38 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51216 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316548AbSHGXqh>; Wed, 7 Aug 2002 19:46:37 -0400
Date: Wed, 7 Aug 2002 19:44:10 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Steven Cole <elenstev@mesatop.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>,
       Steven Cole <scole@lanl.gov>
Subject: Re: Linux v2.4.19-rc5
In-Reply-To: <Pine.LNX.4.44L.0208071939190.23404-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.3.96.1020807193425.14463K-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Rik van Riel wrote:

> On Wed, 7 Aug 2002, Bill Davidsen wrote:
> 
> > Thanks much for the clarification, the data are useful even if they do
> > show room for improvement in the corner case.
> 
> If dbench numbers are meaningful to you, maybe you could
> translate them into something kernel developers can
> understand ? ;)

Sure, glad to. If the 2.5 numbers are much worse than 2.4, somthing isn't
working as well, another problem, go have a beer to drown your sorrow. On
the other hand if it runs much better, you have done a great job and can
go have a beer to celebrate.

Seriously, I would read the reasonably smooth curve of values as good
sign, as opposed to "gets real badd and improves under more load" or
similar. And the fact that it stayed up, and presumably didn't eat all the
filesystems indicates that the system is getting more stable IDE.

One more thing, if you have been fighting bad machines for 15 hours and no
one is looking, it's time to go get a beer. And cashews, and cheddar. I am
out of here (as in where I am working right now, not my office).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

