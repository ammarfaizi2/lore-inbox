Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130575AbQKORfE>; Wed, 15 Nov 2000 12:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129890AbQKORey>; Wed, 15 Nov 2000 12:34:54 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:16389 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129069AbQKORem>; Wed, 15 Nov 2000 12:34:42 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDD0E@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>, Greg KH <greg@wirex.com>,
        "'jerdfelt@valinux.com'" <jerdfelt@valinux.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: RE: Patch(?): linux-2.4.0-test11-pre4/drivers/sound/yss225.c  com
	pilefailure
Date: Wed, 15 Nov 2000 09:03:45 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
> 
> Greg KH wrote:
> > On Wed, Nov 15, 2000 at 12:29:15AM -0500, Jeff Garzik wrote:
> > > If we are going to create CONFIG_USB_HOTPLUG, we must -eliminate-
> > > CONFIG_HOTPLUG, and create CONFIG_PCI_HOTPLUG, and
> > > CONFIG_ANOTHERBUS_HOTPLUG and so on, for each hotplug bus.
> > 
> > Argh!
> > I thought the whole point of this was to make there be only 
> one hotplug
> > strategy, due to the fact that this is a real need.
> > 
> > Please let's not go down this path.  It was all starting to look so
> > nice...
> 
> I -want- there to be only one hotplug strategy, but Adam seemed to be
> talking about the opposite, with his CONFIG_USB_HOTPLUG suggestion.

I told Adam that I didn't want that patch, but it's not
up to me now.

> I'm hoping that Linus will disagree with the splintering of
> CONFIG_HOTPLUG too...

And JE.

> I think it's too late in 2.4.x cycle to change now anyway.

And I told Adam that also.

> 	Jeff

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
