Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVHWJ1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVHWJ1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 05:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVHWJ1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 05:27:18 -0400
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:14608
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S932108AbVHWJ1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 05:27:17 -0400
Date: Tue, 23 Aug 2005 02:20:55 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       David Hinds <dhinds@sonic.net>, "Hesse, Christian" <mail@earthworm.de>,
       linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: Re: IRQ problem with PCMCIA
In-Reply-To: <1124706770.7281.13.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10508230213500.9659-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

The old code can be fixed, just I don't have the time or any desire to
look at it again, still.  The burn out from the last issues from
2001-2003, cost me some health problems over the stress.  

If I encounter these problems and become annoyed enough, I will fix it.
However, if it is cheaper to buy working hardware, that is the route I
will take.

You (Alan), if anyone knows anything can be done in Linux, otherwise none
of us would have ever put this much effort into its success.

Cheers,

Andre


On Mon, 22 Aug 2005, Alan Cox wrote:

> On Llu, 2005-08-22 at 11:25 +0200, Bartlomiej Zolnierkiewicz wrote:
> > CardBus IDE devices work just fine but there are still issues with
> > hotplug support (work in progress).
> 
> "work in progress". Yes because I submitted working IDE cardbus hotplug
> support, and Mark Lord submitted a Delkin driver both of which worked
> months ago rather nicely and neither of which hit the Bartlomiej stone
> wall and never got in and are now stale patches.
> 
> > > up ever getting those into the kernel. Please wait instead for the new
> > > SATA/ATA layer to develop hotplug support.
> > 
> > This is just a FUD to discourage people from working on IDE drivers.
> > Alan is doing this on purpose and doesn't really want to improve things.
> 
> Its a realistic assessment based upon over ten years working on the
> Linux kernel. I do not believe you are capable of fixing the old IDE
> code. But don't take that personally I am sceptical than anyone can fix
> the old IDE code.
> 
> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

