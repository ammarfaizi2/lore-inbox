Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289369AbSAOCXR>; Mon, 14 Jan 2002 21:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289367AbSAOCXH>; Mon, 14 Jan 2002 21:23:07 -0500
Received: from pl100.nas921.ichikawa.nttpc.ne.jp ([210.165.234.100]:47162 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S289361AbSAOCWv>;
	Mon, 14 Jan 2002 21:22:51 -0500
Date: Tue, 15 Jan 2002 11:22:39 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Rob Landley <landley@trommello.org>
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-Id: <20020115112239.25e713e0.bruce@ask.ne.jp>
In-Reply-To: <20020114234129.MGOI23959.femail47.sdc1.sfba.home.com@there>
In-Reply-To: <20020114125228.B14747@thyrsus.com>
	<20020114173423.A23081@thyrsus.com>
	<20020115080218.7709cef7.bruce@ask.ne.jp>
	<20020114234129.MGOI23959.femail47.sdc1.sfba.home.com@there>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002 10:39:25 -0500
Rob Landley <landley@trommello.org> wrote:

> On Monday 14 January 2002 06:02 pm, Bruce Harada wrote:
> > On Mon, 14 Jan 2002 17:34:23 -0500
> >
> > Aunt Tillie just DOESN'T CARE, OK? She can talk to her vendor if she gets
> > worried about whether her kernel supports the Flangelistic2000
SuperDoodad.
> 
> I think what Eric's REALLY going for is converting some of the Minesweeper 
> Certified Solitaire Experts down at the corner store (and yes there are still 
> corner computer stores in mini-malls around the country) over to The Penguin. 

Er... if Eric were REALLY going for that, why didn't he use it as an example?
That might actually be a possible real-world situation, whereas all the ones
I've seen so far are so far removed from reality as to be pointless.

Let me put it this way: Requiring Aunt Tillie to configure/compile her kernel
is a *failure* on the part of the vendor. It doesn't matter whether Aunt
Tillie is really Aunt Tillie or your local MSCE. They should not have to do it.

As for adding a driver that's not included in the vendor's kernel, do you
mean that having a Microsoft-trained drone rebuild a kernel specifically for a
certain PC (thus requiring further compilation for any hardware added later)
and including a no-doubt beta driver and then giving it to Aunt Tillie without
any testing beyond the MCSE's PC is a *good* idea?

(I've trimmed the cc line a bit, BTW.)

