Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbTKDVOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 16:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbTKDVOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 16:14:32 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:18195
	"EHLO muru.com") by vger.kernel.org with ESMTP id S262573AbTKDVOb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 16:14:31 -0500
Date: Tue, 4 Nov 2003 13:14:28 -0800
To: john stultz <johnstul@us.ibm.com>
Cc: Pasi Savolainen <pasi.savolainen@hut.fi>,
       lkml <linux-kernel@vger.kernel.org>, clepple@ghz.cc
Subject: Re: [PATCH] amd76x_pm on 2.6.0-test9 cleanup
Message-ID: <20031104211428.GF1042@atomide.com>
References: <20031104002243.GC1281@atomide.com> <1067971295.11436.66.camel@cog.beaverton.ibm.com> <20031104191504.GB1042@atomide.com> <20031104202104.GA408936@kosh.hut.fi> <20031104205547.GE1042@atomide.com> <1067979476.11432.70.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067979476.11432.70.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.4i
From: Tony Lindgren <tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* john stultz <johnstul@us.ibm.com> [031104 13:00]:
> On Tue, 2003-11-04 at 12:55, Tony Lindgren wrote:
> > * Pasi Savolainen <pasi.savolainen@hut.fi> [031104 12:21]:
> > > * Tony Lindgren <tony@atomide.com> [031104 21:24]:
> > > > * john stultz <johnstul@us.ibm.com> [031104 10:43]:
> > > > > On Mon, 2003-11-03 at 16:22, Tony Lindgren wrote:
> > > > > I've received some reports that this patch causes time problems.
> > > > > 
> > > > > Have those issues been looked into further, or addressed? 
> > > > 
> > > > I've heard of timing problems if it's compiled in, but supposedly they don't
> > > > happen when loaded as module.
> > > 
> > > Not happening since 2.6.0-test9. Don't know what really fixed it, but
> > > they're just not there anymore.
> > 
> > Weird, John, is this true on your S2460 also?
> 
> I don't have any such hardware. I just saw related problem reports
> dealing with the time code and wanted to make sure they were addressed.

Sorry, meant to ask Charles. Looks like he already is going to check it.

Tony
