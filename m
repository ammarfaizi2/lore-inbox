Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbUCDTZb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 14:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUCDTZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 14:25:31 -0500
Received: from ambr.mtholyoke.edu ([138.110.1.10]:784 "EHLO ambr.mtholyoke.edu")
	by vger.kernel.org with ESMTP id S262112AbUCDTYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 14:24:40 -0500
Date: Thu, 4 Mar 2004 14:24:39 -0500 (EST)
From: Ron Peterson <rpeterso@MtHolyoke.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
In-Reply-To: <Pine.OSF.4.21.0402251410240.493062-100000@mhc.mtholyoke.edu>
Message-ID: <Pine.OSF.4.21.0403041415400.195051-100000@mhc.mtholyoke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Feb 2004, Ron Peterson wrote:

> On Tue, 24 Feb 2004, Ron Peterson wrote:
> 
> > I've also added some graphs of must monitoring mist (which is the machine
> > I actually care about the most right now).  Mist ping latencies are
> > predictably on the upswing again.  I'll likely be rebooting soon.
> > 
> > http://depot.mtholyoke.edu:8080/tmp/must-mist/2002-02-24_8:40/
> 
> I've had to turn my attention to some other responsibilities, so I haven't
> done any kernel profiling yet.  However, I can report that I rebooted
> 'mist' into 2.4.20 yesterday, and I have seen rock solid .15 ms response
> times for more than 24 hours.  Host 'must' is likewise now stable, running
> 2.4.20 for two days now.  I have graphs, logs, etc. if anyone cares to see
> them.

These machines remain very stable at 2.4.20.

I don't know where things currently stand vis-a-vis knowing what's
causing this network/system load creep problem, but I thought I'd report
that I installed 2.4.21 on a single processor about a week ago (1GHz PIII,
500MB, Intel 82820 (ICH2) Chipset w/ eepro100 module), and am seeing the
same bad behaviour.  I have very clear graphs, if that's useful, but
haven't been logging system stats as aggressively as on some other
machines.

So something between 2.4.20 and 2.4.21, I think.  I wish I could be more
helpfull..

_________________________
Ron Peterson
Network & Systems Manager
Mount Holyoke College

