Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbTJNQjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 12:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbTJNQjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 12:39:47 -0400
Received: from [80.88.36.193] ([80.88.36.193]:24040 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262587AbTJNQjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 12:39:45 -0400
Date: Tue, 14 Oct 2003 18:39:40 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Thomas Winischhofer <thomas@winischhofer.net>
cc: Meelis Roos <mroos@linux.ee>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: gcc -msoft-float [Was: Linux 2.6.0-test7 - stability freeze]
In-Reply-To: <3F8BF859.2050806@winischhofer.net>
Message-ID: <Pine.GSO.4.21.0310141839130.15051-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003, Thomas Winischhofer wrote:
> Meelis Roos wrote:
> > TW> This is a framebuffer driver and like all fbdev-related stuff it is 
> > TW> properly maintained in the fbdev-tree, waiting to merged into mainline.
> > 
> > Since James seems busy, someone should step up, split these changes into
> > patches, test (or let people test) them separately and submit to kernel.
> > Of course in coordination with James, he knows hat should be stable and
> > what not. I would take this myself by have not enough time.
> 
> That sounds a little like "Linus is busy, let someone else quickly hop 
> in"... :)
> 
> The fbdev tree is quite well tested AFAIK, and I am sure James will 
> respond soon. He can't be too busy, as he was working on the tree yesterday.

Indeed. James said he was going to submit the patches after he has fixed a
critical problem with the soft cursor code.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

