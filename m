Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbTD1OTy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 10:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbTD1OTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 10:19:54 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:26758 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S261157AbTD1OTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 10:19:52 -0400
Date: Mon, 28 Apr 2003 16:30:10 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Zack Gilburd <zack@tehunlose.com>
cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
In-Reply-To: <20030428070128.566ede0a.zack@tehunlose.com>
Message-ID: <Pine.GSO.4.21.0304281629330.11373-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Apr 2003, Zack Gilburd wrote:
> On Mon, 28 Apr 2003 03:35:10 -0700 (PDT)
> Andre Hedrick <andre@linux-ide.org> wrote:
> 
> > There is one fundamental problem, and nobody has addressed.
> > 
> > Who will enforce the GPL over DRM violations?
> > Since it is a blanket over the entire kernel, and you have formally
> > (for the most part) have authorized DRM, thus one assumes you are the only
> > one who can pursue in a court of law.
> 
> Unless I am missing something, I was hoping for more of a sparse DRM implementation; not a blanket.
> 
> I was hoping to be able to `modprobe drm` for when I needed to use DRM and likewise `rmmod drm` for when I didn't want it.  Maybe I am a little late in this disucssion, but that's just my hopes and whishes.

Unfortunately that's not going to work, since your DRM module cannot trust the
kernel it's loaded by.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

