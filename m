Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUFMVEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUFMVEL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 17:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUFMVEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 17:04:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5505 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261162AbUFMVEI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 17:04:08 -0400
Date: Sun, 13 Jun 2004 18:04:00 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, Ryan Underwood <nemesis-lists@icequake.net>,
       Willy Tarreau <willy@w.ods.org>
Subject: Re: Request: Netmos support in parport_serial for 2.4.27
Message-ID: <20040613210400.GA4684@logos.cnet>
References: <20040613111949.GB6564@dbz.icequake.net> <20040613123950.GA3332@logos.cnet> <Pine.LNX.4.56.0406132225020.5930@jjulnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0406132225020.5930@jjulnx.backbone.dif.dk>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 10:30:35PM +0200, Jesper Juhl wrote:
> On Sun, 13 Jun 2004, Marcelo Tosatti wrote:
> 
> > n Sun, Jun 13, 2004 at 06:19:49AM -0500, Ryan Underwood wrote:
> > >
> > > Hi,
> > >
> > > There's been a patch floating around for a while now to add Netmos
> > > support to parport_serial.  It has been submitted numerous times but it
> > > seems that nobody notices it. :)
> > >
> > > Can it be reviewed for inclusion before 2.4.27?  I have a few systems
> > > with these cards and it would be very nice to have them up to snuff.
> > >
> > > The patch against 2.4.20 can be found here:
> > > http://winterwolf.co.uk/linuxsw
> >
> > Hi Ryan,
> >
> > Care to submit the patch inlined in another email message?
> >
> 
> Here are the original patches from http://winterwolf.co.uk/linuxsw
> An attempt of mine to update them for 2.4.27-pre5 can be found elsewhere
> in this thread.

Ok, someone sent me this patch already but did not I merge it,
for no good reason. Even Tim ACked.

I'll apply it, thanks.
