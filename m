Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWDXUyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWDXUyo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWDXUyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:54:44 -0400
Received: from witte.sonytel.be ([80.88.33.193]:39048 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751271AbWDXUyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:54:43 -0400
Date: Mon, 24 Apr 2006 22:54:36 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Gary Poppitz <poppitzg@iomega.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
In-Reply-To: <Pine.LNX.4.61.0604241537440.24459@chaos.analogic.com>
Message-ID: <Pine.LNX.4.62.0604242252340.15928@pademelon.sonytel.be>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
 <Pine.LNX.4.61.0604241537440.24459@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2006, linux-os (Dick Johnson) wrote:
> On Mon, 24 Apr 2006, Gary Poppitz wrote:
> > I have the task of porting an existing file system to Linux. This
> > code is in C++ and I have noticed that the Linux kernel has
> > made use of C++ keywords and other things that make it incompatible.
> >
> > I would be most willing to point out the areas that need adjustment
> > and supply patch files to be reviewed.
> >
> > What would be the best procedure to accomplish this?
> 
> Rewrite the file-system in C. The kernel is written in 'C' and
> assembly.

Preferably C, unless you want to code for +20 architectures in parallel ;-)

> to DeliveryErrors@analogic.com - and destroy all copies of this information,
> including any attachments, without reading or disclosing them.

Aarghl, again I forgot lawyers read from bottom to top...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
