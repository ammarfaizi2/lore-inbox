Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSHIRt0>; Fri, 9 Aug 2002 13:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSHIRt0>; Fri, 9 Aug 2002 13:49:26 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:32017 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315337AbSHIRtY>; Fri, 9 Aug 2002 13:49:24 -0400
Date: Fri, 9 Aug 2002 13:46:56 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.4.19-rc5
In-Reply-To: <Pine.LNX.4.44L.0208072053240.23404-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.3.96.1020809133500.23512C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Rik van Riel wrote:

> On Wed, 7 Aug 2002, Bill Davidsen wrote:
> 
> > Sure, glad to. If the 2.5 numbers are much worse than 2.4, somthing
> > isn't working as well,
> 
> Are you volunteering to identify that "something" for us ?

Hell no. I was simply commenting that there is some general qualitative
information available from those numbers, even if it is hard to quantify
them. Not working as well for a benchmark may indicate much better typical
performance, and as I understand dbench the io scheduler may improve that
significantly as well.

No, clearly there are other, probably a lot more representative numbers,
which show 2.5 is better. "Isn't working as well" for one thing doesn't
mean "in general," but might be of interest to the primary developers.

The fact that the curve doesn't end in a reload from backup tells me that
the IDE code is much better that it was ;-)

What time I have for diddling kernel code is spent on making network code
changes, and is all against 2.4 base. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

