Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbUBZQoP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 11:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbUBZQoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 11:44:14 -0500
Received: from witte.sonytel.be ([80.88.33.193]:5341 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262821AbUBZQoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 11:44:10 -0500
Date: Thu, 26 Feb 2004 17:44:04 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: tulip-users@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] Tulip 21041 port breakage
In-Reply-To: <403E20CC.7070109@pobox.com>
Message-ID: <Pine.GSO.4.58.0402261739050.17026@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0401031203001.3219@waterleaf.sonytel.be>
 <403E20CC.7070109@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Jeff,

On Thu, 26 Feb 2004, Jeff Garzik wrote:
> Thanks, I'll throw this into the 2.4 tree.

Thanks!

> Does de2104x work for you in 2.6?

Yes, it does. But I haven't really _used_ 2.6 on that box, so I don't know
whether the same problem occurs in 2.6.

So far the problem got triggered only twice since I upgraded to 2.4.23 about 3
months ago. I wanted to be sure it still happened, that's why it took me that
long to resend the patch...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
