Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278465AbRJOWjE>; Mon, 15 Oct 2001 18:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278466AbRJOWi5>; Mon, 15 Oct 2001 18:38:57 -0400
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:9228 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S278465AbRJOWir>;
	Mon, 15 Oct 2001 18:38:47 -0400
Date: Mon, 15 Oct 2001 15:41:10 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Tim Moore <timothymoore@bigfoot.com>,
        Slo Mo Snail <slomo@beermail.no-ip.com>,
        "M. Edward (Ed) Borasky" <znmeb@aracnet.com>,
        linux-kernel@vger.kernel.org
Subject: Re: How many versions of VM are there?
In-Reply-To: <20011015152942.D4482@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.10.10110151540180.1386-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001, Mike Fedyk wrote:

> On Mon, Oct 15, 2001 at 03:24:48PM -0700, Tim Moore wrote:
> > Mike Fedyk wrote:
> > > 
> > > On Mon, Oct 15, 2001 at 10:58:22PM +0200, Slo Mo Snail wrote:
> > > > As far as I know there are 2 different version of VM:
> > > > 2.2.x and 2.4.x-acyy: Rik von Riel's VM (but I'm not sure wether it's the
> > > > same VM)
> > > 
> > > No.
> > > 
> > > It's not the same VM.  2.2 had a VM change from Andrea at about 2.2.17-18,
> > > don't know about before...
> > 
> > 2.2.19pre2
> > o       Drop the page aging for a moment to merge the
> >         Andrea VM
> > o       Merge Andrea's VM-global patch                  (Andrea
> > Arcangeli)
> > 
> 
> So 2.2 used page aging like 2.0 and 2.4 until 2.2.19pre2?

AFIK there were some changes to the VM during the mid 2.1.x series.

	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

