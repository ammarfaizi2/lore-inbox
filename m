Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267731AbTBYGuD>; Tue, 25 Feb 2003 01:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267732AbTBYGuD>; Tue, 25 Feb 2003 01:50:03 -0500
Received: from mailhost.NMT.EDU ([129.138.4.52]:46609 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S267731AbTBYGuC>;
	Tue, 25 Feb 2003 01:50:02 -0500
Date: Tue, 25 Feb 2003 00:00:12 -0700
From: Val Henson <val@nmt.edu>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225070012.GC25680@boardwalk>
References: <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com> <20030224075142.GA10396@holomorphy.com> <20030224154725.GB5665@work.bitmover.com> <20030224233638.GS10411@holomorphy.com> <20030225002309.GA12146@work.bitmover.com> <20030225044236.GB10396@holomorphy.com> <20030225045404.GA26831@work.bitmover.com> <20030225060053.GC10396@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225060053.GC10396@holomorphy.com>
User-Agent: Mutt/1.4i
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 10:00:53PM -0800, William Lee Irwin III wrote:
> On Mon, Feb 24, 2003 at 08:54:04PM -0800, Larry McVoy wrote:
> > That's really great, I know it's a lot less sexy but it's important.
> > I'd love to see as much attention on making Linux work on tiny embedded
> > platforms as there is on making it work on big iron.  Small is cool too.
> 
> There is, unfortunately the participation in the development cycle of
> embedded vendors is not as visible as it is with large system vendors.
> More direct, frequent, and vocal input from embedded kernel hackers
> would be very valuable, as many "corner cases" with automatic kernel
> scaling should occur on the small end, not just the large end.
> 
> I've had some brief attempts to explain to me the motives and methods
> of embedded system vendors and the like, but I've failed to absorb
> enough to get a "big picture" or much of any notion as to why embedded
> kernel hackers aren't participating as much in the development cycle.

Speaking as a former Linux developer for an embedded[1] systems
vendor, it's because embedded companies aren't the size of IBM and
don't have money to spend on software development beyond the "make it
work on our boards" point.  One of the many reasons I'm a _former_
embedded Linux developer.

-VAL

[1] Okay, our boards had up to 4 processors and 1GB memory.  But the
same principles applied.
