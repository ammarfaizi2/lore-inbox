Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268398AbTAMWzL>; Mon, 13 Jan 2003 17:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268399AbTAMWzL>; Mon, 13 Jan 2003 17:55:11 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:56838 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268398AbTAMWzK>;
	Mon, 13 Jan 2003 17:55:10 -0500
Date: Mon, 13 Jan 2003 15:03:59 -0800
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@neo.rr.com>, Jaroslav Kysela <perex@suse.cz>,
       Linus Torvalds <torvalds@transmeta.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>, Shawn Starr <spstarr@sh0n.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PnP update - drivers
Message-ID: <20030113230359.GA10073@kroah.com>
References: <Pine.LNX.4.33.0301122025520.611-100000@pnote.perex-int.cz> <20030113173906.GA605@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113173906.GA605@neo.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 05:39:06PM +0000, Adam Belay wrote:
> On Sun, Jan 12, 2003 at 08:30:57PM +0100, Jaroslav Kysela wrote:
> > 	this patch must be applied after PnP patch v0.94. It contains my
> > small cleanups of PnP code and I tried to rewrite almost all ISA PnP
> > drivers to new PnP subsystem except sound drivers (ALSA & OSS). Please,
> > apply to get away compilation problems.
> 
> Hi Jaroslav,
> 
> Next time send pnp related changes to me directly.

And Adam, sorry for taking so long in getting your previous changes you
sent to me to Linus.  That's my fault, it was in my queue to review when
Jaroslav sent his patches.  I guess now I'll just wait for this merge
mess to get cleaned up :(

greg k-h
