Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272551AbTGZPMZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 11:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270140AbTGZPLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 11:11:49 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:29874 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S272551AbTGZPJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 11:09:53 -0400
Date: Sat, 26 Jul 2003 17:25:03 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Bernd Eckenfels <ecki-lkm@lina.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 -> 2.2 differences?
In-Reply-To: <1059177773.1204.22.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0307261724050.28756-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Jul 2003, Alan Cox wrote:
> On Sad, 2003-07-26 at 00:29, Bernd Eckenfels wrote:
> > In article <20030725142434.GS32585@rdlg.net> you wrote:
> > > With all the SCO fun going on I have people asking me what functionality
> > > we would loose if we rolled from 2.4.21 kernel to the last known stable
> > > 2.2 kernel.
> > 
> > it is easier to turn off SMP.
> > 
> > BTW: what will happen if there is some SMP code from IBM in the kernel which
> > is owned by SCO? Isnt it a matter of days to remove that code? Does anybody
> > have to pay for past usage of the code?
> 
> The core 2.2 SMP code is stuff I wrote. Caldera (aka SCO) even provided
> me the hardware and asked me to do it. The later table parser code is
> from Intel.

Did you open up the boxes? Perhaps there was some license note attached to the
internals (`by using this machine, you declare to give up your first born
etc... ')?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

