Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbTCKT7m>; Tue, 11 Mar 2003 14:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261590AbTCKT7m>; Tue, 11 Mar 2003 14:59:42 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:41226 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261587AbTCKT7l>; Tue, 11 Mar 2003 14:59:41 -0500
Date: Tue, 11 Mar 2003 21:09:17 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Patrick Mochel <mochel@osdl.org>
cc: Greg KH <greg@kroah.com>, Oliver Neukum <oliver@neukum.name>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PCI driver module unload race?
In-Reply-To: <Pine.LNX.4.33.0303110916540.1003-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303112104500.5042-100000@serv>
References: <Pine.LNX.4.33.0303110916540.1003-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 11 Mar 2003, Patrick Mochel wrote:

> > > CONFIG_MODULE_UNLOAD, just say no.
> > 
> > That's certainly an option, but I'm afraid not too many people will do 
> > this.
> 
> Greg, and Rusty, are right. Dealing with this is a PITA, and I think will 
> always be. I'm willing to take the Nancy Reagan platform, too. 

Right with what? I think the problem is complex enough, that it's beyond a 
simple right/wrong scheme.
What is the "Nancy Reagan platform"?

bye, Roman

