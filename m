Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266509AbSKGKaX>; Thu, 7 Nov 2002 05:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266508AbSKGKaW>; Thu, 7 Nov 2002 05:30:22 -0500
Received: from cmailm2.svr.pol.co.uk ([195.92.193.210]:4115 "EHLO
	cmailm2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266509AbSKGKaV>; Thu, 7 Nov 2002 05:30:21 -0500
Date: Thu, 7 Nov 2002 10:37:31 +0000
To: linux-kernel@vger.kernel.org
Subject: Re: [Evms-announce] EVMS announcement
Message-ID: <20021107103731.GB1770@reti>
References: <02110516191004.07074@boiler> <20021105214012.C2B4651CF@dominion.dyndns.org> <20021106001856.GD1092@gnu.org> <20021106213329.GH25580@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106213329.GH25580@merlin.emma.line.org>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 10:33:29PM +0100, Matthias Andree wrote:
> On Wed, 06 Nov 2002, Andrew Clausen wrote:
> 
> > On Tue, Nov 05, 2002 at 04:00:10PM -0500, Mike Diehl wrote:
> > > Well, I'm a bit disapointed.  My experience with LVM has been nothing short 
> > > of disasterous;
> > 
> > I think you'll find LVM2 much more pleasant than LVM1.  It's a
> > reimplementation with a very different (minimalist :) architecture.
> 
> What's the current LVM2 status? I've got EVMS up and running in a couple
> of minutes, but finding LVM2 stuff, let alone documentation, gives me a
> hard time. And yes I know it's the testing stuff at sistina.com, so I
> hope I'm looking at the right web site...

Sistina has a new website, it took me quite a few clicks to find where
they'd hidden stuff:

http://www.sistina.com/products_lvm_download.htm

or

ftp://ftp.sistina.com/pub/LVM2/

I consider LVM2 to be more bug free than LVM1, the only thing holding
people back is the fact that they will have to patch the kernel to get
dm.  Then upgrading from LVM1 is simply a question of building
libdevmapper and the LVM2 tools and using them.  There will be a new
release next week that will a bit more documentation.

- Joe
