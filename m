Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266484AbUGUOwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266484AbUGUOwg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 10:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266501AbUGUOwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 10:52:36 -0400
Received: from witte.sonytel.be ([80.88.33.193]:22510 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266484AbUGUOwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 10:52:34 -0400
Date: Wed, 21 Jul 2004 16:52:30 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Oliver Neukum <oliver@neukum.org>
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] delete devfs
In-Reply-To: <200407211626.55670.oliver@neukum.org>
Message-ID: <Pine.GSO.4.58.0407211648580.8147@waterleaf.sonytel.be>
References: <20040721141524.GA12564@kroah.com> <200407211626.55670.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2004, Oliver Neukum wrote:
> Am Mittwoch, 21. Juli 2004 16:15 schrieb Greg KH:
> > Hm, seems kernel.org dropped my big patch, so the patch below can be
> > found at:
> > 	www.kernel.org/pub/linux/kernel/people/gregkh/misc/2.6/devfs-delete-2.6.8-rc2.patch
>
> May I point out that 2.6 is supposed to be a _stable_ series?

Quoting GregKH: `to test out the new development model', i.e. the one
established at the Kernel Summit yesterday afternoon :-)

Well, looking at the late (or early :-) hour he sent out the patch, it looks
like he did need a few beers before he gained enough confidence in this `new
development model' :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
