Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269310AbUINOLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269310AbUINOLI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 10:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269311AbUINOLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 10:11:08 -0400
Received: from main.gmane.org ([80.91.229.2]:11410 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269310AbUINOKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 10:10:54 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Mario R. Carro" <mcarro@threads-srl.com>
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97   patch)
Date: Tue, 14 Sep 2004 10:19:56 -0300
Message-ID: <ci6r66$uhs$1@sea.gmane.org>
References: <200409111850.i8BIowaq013662@harpo.it.uu.se> <20040912011128.031f804a@localhost> <Pine.LNX.4.60.0409131526050.29875@tomservo.workpc.tds.net>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 200.80.238.173
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2800.1437
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have one a PCI based one, branded as OvisLink.

MRC

-- 

THREADS SRL
Tel:    (54-291) 488-7451
e-Mail: info@threads-srl.com
Web:    www.threads-srl.com

"David Lloyd" <dmlloyd@tds.net> escribió en el mensaje
news:Pine.LNX.4.60.0409131526050.29875@tomservo.workpc.tds.net...
> On Sun, 12 Sep 2004, SashaK wrote:
>
> > On Sat, 11 Sep 2004 20:50:58 +0200 (MEST)
> > Mikael Pettersson <mikpe@csd.uu.se> wrote:
> >
> >> No, I meant the 'slamr' kernel driver module, which is
> >> built from a big binary-only library (amrlibs.o) and
> >> a small amount of kernel glue source code. As long as
> >> amrlibs.o is distributed only as a 32-bit x86 binary,
> >> I won't be able to use it with a 64-bit amd64 kernel.
> >
> > This is exactly that was discussed - 'slamr' is going to be replaced by
> > ALSA drivers. I don't know which modem you have, but recent ALSA driver
> > (CVS version) already supports ICH, SiS, NForce (snd-intel8x0m), ATI IXP
> > (snd-atiixp-modem) and VIA (snd-via82xx-modem) AC97 modems.
>
> Are these all motherboard-chipset modems, or is there such a thing as an
> AC97-based PCI modem card?
>
> - D




