Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbTJLJQZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 05:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263438AbTJLJQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 05:16:25 -0400
Received: from [80.88.36.193] ([80.88.36.193]:42112 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263436AbTJLJQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 05:16:24 -0400
Date: Sun, 12 Oct 2003 11:16:03 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "David S. Miller" <davem@redhat.com>
cc: Michael Hunold <hunold@convergence.de>, shemminger@osdl.org,
       linux-dvb@linuxtv.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/14] LinuxTV.org DVB driver update
In-Reply-To: <20031011105320.1c9d46db.davem@redhat.com>
Message-ID: <Pine.GSO.4.21.0310121115260.27309-100000@starflower.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Oct 2003, David S. Miller wrote:
> On Sat, 11 Oct 2003 10:41:43 +0200
> Michael Hunold <hunold@convergence.de> wrote:
> 
> > Unfortunately, I don't notice every patch that goes directly into 2.6 
> > without getting postet on the linux-dvb mailinglist. Now if someone 
> > changes stuff in our CVS in the same file, it can happen that the stuff 
> > from the kernel is wiped out.
> 
> It is your responsibility to resolve such things though.  It is
> inevitable and unavoidable that others outside of your development
> group will make many changes to your files, as we fix bugs that
> are tree-wide.

So you best subscribe to bk-commits-head and monitor every patch that affects
drivers/media/dvb/.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

