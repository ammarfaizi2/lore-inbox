Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268162AbUI2IIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268162AbUI2IIU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 04:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268255AbUI2IIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 04:08:20 -0400
Received: from witte.sonytel.be ([80.88.33.193]:63163 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268162AbUI2IIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 04:08:18 -0400
Date: Wed, 29 Sep 2004 10:08:11 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Gene Heskett <gene.heskett@verizon.net>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm4
In-Reply-To: <200409280701.06932.gene.heskett@verizon.net>
Message-ID: <Pine.GSO.4.61.0409291007190.18029@waterleaf.sonytel.be>
References: <20040926181021.2e1b3fe4.akpm@osdl.org> <200409280626.50167.gene.heskett@verizon.net>
 <20040928103324.GA21050@elte.hu> <200409280701.06932.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2004, Gene Heskett wrote:
> On Tuesday 28 September 2004 06:33, Ingo Molnar wrote:
> >(If such a early-bootup lockup happens in the future then you sure
> > could temporarily unplug the ups serial connection and use that as
> > the serial console - for the narrow and temporary purpose of
> > debugging that boot-time hang.)
> 
> That would I assume need a null modem cable, and what do I run on the 
> firewall?  Minicom?  Or is there something better that can just grab 
> and log without being interactive?  Its a rh7.3 box with a 2.4.18 era 
> kernel.  I'd update that, but its not broken. :)

I hate minicom. But cu works fine!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
