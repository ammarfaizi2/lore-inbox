Return-Path: <linux-kernel-owner+w=401wt.eu-S1752376AbWLQKfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbWLQKfG (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 05:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbWLQKfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 05:35:05 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:38014 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752376AbWLQKfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 05:35:04 -0500
X-Greylist: delayed 1425 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 05:35:04 EST
Date: Sun, 17 Dec 2006 11:11:12 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Schwartz <davids@webmaster.com>
cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKCEAPAGAC.davids@webmaster.com>
Message-ID: <Pine.LNX.4.62.0612171109180.27120@pademelon.sonytel.be>
References: <MDEHLPKNGKAHNMBLJOLKCEAPAGAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006, David Schwartz wrote:
> > And there's also the common misconception all costumers had enough
> > information when buying something. If you are a normal Linux user and
> > buy some hardware labelled "runs under Linux", it could turn out that's
> > with a Windows driver running under ndiswrapper...
> 
> That is something that I think is well worth fixing. Doesn't Linus own the
> trademark 'Linux'? How about some rules for use of that trademark and a
> 'Works with Linux' logo that can only be used if the hardware specifications
> are provided?

Exactly my thoughts...

> Let them provide a closed-source driver if they want. Let them provide
> user-space applications for which no source is provided if they want. But
> don't let them use the logo unless they release sufficient information to
> allow people to develop their own drivers and applications to interface with
> the hardware.
> 
> That makes it clear that it's not about giving us the fruits of years of
> your own work but that it's about enabling us to do our own work. (I would
> have no objection to also requiring them to provide a minimal open-source
> driver. I'm not trying to work out the exact terms here, just get the idea
> out.)

Since `works with' may sound a bit too vague, something like
`LinuxFriendly(tm)', with a happy penguin logo?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
