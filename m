Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWA1VQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWA1VQb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 16:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWA1VQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 16:16:31 -0500
Received: from relay00.pair.com ([209.68.5.9]:31753 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S1750739AbWA1VQa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 16:16:30 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
To: Otto Wyss <otto.wyss@orpatec.ch>
Subject: Re: OSDL and the Linux kernel community
Date: Sat, 28 Jan 2006 15:16:06 -0600
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <43DB8EC3.5040907@orpatec.ch>
In-Reply-To: <43DB8EC3.5040907@orpatec.ch>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601281516.28110.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 January 2006 09:33, Otto Wyss wrote:
> First I have to mention that the kernel is an important but only _one_
> part of a Linux system a user may buy in a shop. There are many more
> parts which have to fit in until a system is bought. IMO the OSDL's task
> is to care for all of these parts, not only at the kernel. Nobody will
> buy a computer if it only has a superb kernel but the rest doesn't fit
> equally well.

Yes, but if the kernel doesn't support the user's wireless chipset and all 
they can get is binary blob drivers for their graphics cards, the rest of the 
system will seem naturally worse.

> Well the answers is quite simple, it means a low market share! A market
> share so low that manufactures don't care about providing drivers, even
> so low they don't even provide documentation. Too low that vendors don't
> care for using parts which have Linux drivers, let alone selling Linux
> systems even if it's cheaper for them. Don't you think it is much more
> important to raise the market share above a minimal necessary level?

This problem exists, but even ATI and NVIDIA both recognize that there is a 
market for linux users. So they provide (some) level of effort to write 
drivers. It's probably their concerns about IP and the IP climate that keep 
their drivers closed.

> So if Linux should finally become widespread used by everybody my
> “cross-platform development” initiative (see
> http://wyoguide.sourceforge.net/index.php?page=Cross-platform.html) has
> to succeed. Only then becomes a Linux system attractive for the ordinary
> users and therefore for the vendors and the manufactures.

I don't see how cross-platform development makes Linux attractive to 
"ordinary" (non-developer) users. I don't think asking everyone to swallow 
some red pill is going to make anything any bit better.

Cross platform toolkits like GTK and Qt already exist. Last I heard, Trolltech 
even had some large customers (Adobe, etc), so who knows - maybe Photoshop on 
X isn't so long off?

> You may ask now why do I tell this here and wonder what you have to do
> with. Well first it was Greg Kroah-Hartman proposal to the OSDL and
> second because I think my proposal will solve many of the limitations
> you currently face in your work. I think you are well advised to
> advocate this to the OSDL so they finally look for a desktop architect
> in their fellowship program

The limitations kernel developers currently face is in the availability of 
documentation and the cooperation of manufacturers. While the rise of Linux 
adoption will help this, it's up to the desktop people (read: desktop 
architects) to worry about desktop stuff. I'm a subscriber there too, and I 
realize you didn't feel all that at home with your guidelines, but don't you 
think LKML is the wrong place to be airing them?

I read Greg's words on OSDL too, and it seems (from where I stand, anyways) 
that things are going well in that area. But that initiative is focused on 
the kernel and kernel developers, and yours is focused on desktop.

> O. Wyss

Cheers,
Chase
