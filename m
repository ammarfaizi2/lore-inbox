Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265089AbUD3JdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265089AbUD3JdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 05:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265131AbUD3JdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 05:33:25 -0400
Received: from witte.sonytel.be ([80.88.33.193]:39308 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265089AbUD3JdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 05:33:23 -0400
Date: Fri, 30 Apr 2004 11:33:20 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Matthias Schniedermeyer <ms@citd.de>
cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Symbios and BIOS (was: Re: [PATCH] Blacklist binary-only modules
 lying about their license)
In-Reply-To: <20040430060146.GA10826@citd.de>
Message-ID: <Pine.GSO.4.58.0404301132140.8585@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com>
 <40911C01.80609@techsource.com> <20040429213246.GA15988@valve.mbsi.ca>
 <40917DBA.1080308@techsource.com> <6DB1DC9C-9A2B-11D8-B83D-000A95BCAC26@linuxant.com>
 <4091895A.6040800@techsource.com> <20040430060146.GA10826@citd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2004, Matthias Schniedermeyer wrote:
> e.g. The symbios(*1)-SCSI-driver only shows devices enabled in its BIOS.
> This information is stored in a little NVRAM-chip(*2) and the driver
> uses this data, including bus-speed settings and the like.
> At least i (had/have*3) trouble with this "feature"!

So why does my '875 card works fine in my PPC box? No BIOS ever wrote to its
NVRAM.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
