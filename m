Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270966AbRHOAXD>; Tue, 14 Aug 2001 20:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270970AbRHOAWx>; Tue, 14 Aug 2001 20:22:53 -0400
Received: from [207.171.197.68] ([207.171.197.68]:51844 "EHLO bbs.bsdprime.org")
	by vger.kernel.org with ESMTP id <S270966AbRHOAWl>;
	Tue, 14 Aug 2001 20:22:41 -0400
Date: Tue, 14 Aug 2001 17:33:44 -0700 (PDT)
From: Joseph Cheek <joseph@cheek.com>
To: "Peter J. Braam" <braam@clusterfilesystem.com>
cc: Johannes Erdfelt <johannes@erdfelt.com>, linux-kernel@vger.kernel.org,
        linux-usb-users@lists.sourceforge.net, bhards@bigpond.net.au
Subject: Re: [Linux-usb-users] Re: 2.4.8-ac2 USB keyboard capslock hang
In-Reply-To: <20010814181854.J4021@lustre.dyn.ca.clusterfilesystem.com>
Message-ID: <Pine.LNX.4.10.10108141732470.30293-100000@bbs.bsdprime.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hmm, that's probably why brad hards could never get a repro.

brad, did you try on an SMP kernel?

joe

On Tue, 14 Aug 2001, Peter J. Braam wrote:

> Ah - my Rosswell was a UP version.  So we have no information really
> about this bug except that it is SMP. 
> 
> - Peter -
> 
> 
> On Mon, Aug 13, 2001 at 04:11:35PM -0700, Joseph Cheek wrote:
> > which begs the question - what did red hat do that fixed it?
> > 
> > i have tried stock 2.4.6-ac{1,2,5} and they all contained the bug.
> > 
> > joe
> > 
> > Peter J. Braam wrote:
> > 
> > >Ah - but I don't have the difficulties with the Linux beta kernel in
> > >Rosswell (2.4.6-ac?? + red hat patches). 
> > >
> > >It's 100% reproducible here on 2.4.8-ac2 for example - but it does
> > >freeze the system pretty much. What can I do to help?
> > >
> > >- Peter -
> > >
> > >On Mon, Aug 13, 2001 at 12:40:40PM -0700, Joseph Cheek wrote:
> > >
> > >>this bug has been around since 2.4.3-ac *at least*, and the linux-usb 
> > >>folks are aware of it [but can't get a repro].  i've had repros since 
> > >>2.4.3-ac.
> > >>
> > >>this is the first time afaik that this bug has been reported on a non 
> > >>ms-natural-pro keyboard tho.

