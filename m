Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbTHUJyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 05:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbTHUJyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 05:54:04 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:37608 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262541AbTHUJyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 05:54:02 -0400
Date: Thu, 21 Aug 2003 11:42:08 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       akpm@ravnborg.org, Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: kbuild: Separate ouput directory support
In-Reply-To: <20030819215656.GE1791@mars.ravnborg.org>
Message-ID: <Pine.GSO.4.21.0308211141500.11810-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003, Sam Ravnborg wrote:
> On Tue, Aug 19, 2003 at 05:53:33PM -0400, Jeff Garzik wrote:
> > Is it possible, with your patches, to build from a kernel tree on a 
> > read-only medium?
> 
> Yes, thats possible. But I have seen that as a secondary possibility.
> But I know people has asked about the possibility to build a kernel
> from src located on a CD. And thats possible with this patch.

Or from a src tree in ClearCase.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

