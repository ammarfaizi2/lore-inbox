Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261570AbTCKUCI>; Tue, 11 Mar 2003 15:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261571AbTCKUCH>; Tue, 11 Mar 2003 15:02:07 -0500
Received: from air-2.osdl.org ([65.172.181.6]:28387 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261570AbTCKUCG>;
	Tue, 11 Mar 2003 15:02:06 -0500
Date: Tue, 11 Mar 2003 13:15:31 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Greg KH <greg@kroah.com>, Oliver Neukum <oliver@neukum.name>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PCI driver module unload race?
In-Reply-To: <Pine.LNX.4.44.0303112104500.5042-100000@serv>
Message-ID: <Pine.LNX.4.33.0303111314010.1015-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Mar 2003, Roman Zippel wrote:

> Hi,
> 
> On Tue, 11 Mar 2003, Patrick Mochel wrote:
> 
> > > > CONFIG_MODULE_UNLOAD, just say no.
> > > 
> > > That's certainly an option, but I'm afraid not too many people will do 
> > > this.
> > 
> > Greg, and Rusty, are right. Dealing with this is a PITA, and I think will 
> > always be. I'm willing to take the Nancy Reagan platform, too. 
> 
> Right with what? 

With the idea that unloading modules is a bad idea. 

> What is the "Nancy Reagan platform"?

"Just say no". It was a big anti-drug campaign in the US targeted at
schoolchildren, spearheaded in the mid-80's by Nancy Reagan.

	-pat

