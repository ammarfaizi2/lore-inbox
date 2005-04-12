Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVDLIh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVDLIh0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 04:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVDLIhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 04:37:25 -0400
Received: from witte.sonytel.be ([80.88.33.193]:29861 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262042AbVDLIhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 04:37:10 -0400
Date: Tue, 12 Apr 2005 10:36:49 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Daniel Barkalow <barkalow@iabervon.org>
cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: New SCM and commit list
In-Reply-To: <Pine.LNX.4.21.0504111801450.30848-100000@iabervon.org>
Message-ID: <Pine.LNX.4.62.0504121034110.10150@numbat.sonytel.be>
References: <Pine.LNX.4.21.0504111801450.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2005, Daniel Barkalow wrote:
> If merge took trees instead of single files, and had some way of detecting
> renames (or it got additional information about the differences between
> files), would that give BK-quality performance? Or does BK also support

I wrote a script to do merges on a tree (so far without rename detection,
though ;-) a long time ago, and still use it every time Linus or Marcelo
release a new version.

Look at `mergetree' on http://linux-m68k-cvs.ubb.ca/~geert/

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
