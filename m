Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267637AbTALX1t>; Sun, 12 Jan 2003 18:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267638AbTALX1q>; Sun, 12 Jan 2003 18:27:46 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:11532 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267637AbTALX1n>; Sun, 12 Jan 2003 18:27:43 -0500
Date: Mon, 13 Jan 2003 00:36:30 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Honest does not pay here ...
Message-ID: <20030112233630.GB29758@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200301041809.KAA06893@adam.yggdrasil.com> <avaa2r$ggr$1@forge.intermeta.de> <3E18B76B.8050803@cox.net> <avae9i$gv1$1@forge.intermeta.de> <3E18CC4D.1020604@cox.net> <20030106234116.GH10752@merlin.emma.line.org> <3E1A1A2C.2000409@walrond.org> <20030107012429.GA12944@merlin.emma.line.org> <ave8su$u17$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ave8su$u17$1@forge.intermeta.de>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Jan 2003, Henning P. Schmiedehausen wrote:

> Matthias Andree <matthias.andree@gmx.de> writes:
> 
> >> Until the manufacturers start providing good quality supported drivers 
> >> for their hardware, binary or source, linux will stay exactly where it 
> >> is now; a server room tool and a hobbyists playground.
> 
> >> I for one think thats a real shame
> 
> >Only that you can't trust in the el-cheapo vendors claiming Linux
> >support, and an independent certification is needed (not only for Linux,
> >for the *BSDs as well). Without a trusted certification, some crooks may
> >try to claim Linux support and it won't quite work out.
> 
> http://www.cs.helsinki.fi/linux/linux-kernel/2001-35/0559.html
> 
> Dated 5. September 2001.

Close, but I hadn't meant signing in mind, but something like "we write
we support Linux" when they only have 2.0 binary-only modules. I want
the term "Linux compatible" to be certified, not soft- or hardware per
se. Signing drivers is difficult, because of the said problems, and
because a faithful and trustworthy vendor then has to have his stuff
re-certified over and over.

I you happened to read the German c't magazine 1/2003 about RAID
hardware and Linux, or the 2/2003 edition about TV cards, then look at
the pertinent sections to know what I mean.

The other thing (Linus labs) is already there: module tainting...
