Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280569AbRKYPPP>; Sun, 25 Nov 2001 10:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277152AbRKYPPG>; Sun, 25 Nov 2001 10:15:06 -0500
Received: from pl475.nas921.ichikawa.nttpc.ne.jp ([210.165.235.219]:35636 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S280569AbRKYPO4>;
	Sun, 25 Nov 2001 10:14:56 -0500
Date: Mon, 26 Nov 2001 00:14:26 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16-pre1
Message-Id: <20011126001426.1e1995d9.bruce@ask.ne.jp>
In-Reply-To: <tg4rnigano.fsf@mercury.rus.uni-stuttgart.de>
In-Reply-To: <Pine.LNX.4.21.0111241636200.12066-100000@freak.distro.conectiva>
	<20011125143449.B5506@duron.intern.kubla.de>
	<tgadxagbjn.fsf@mercury.rus.uni-stuttgart.de>
	<20011125145134.B23807@flint.arm.linux.org.uk>
	<tg4rnigano.fsf@mercury.rus.uni-stuttgart.de>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Nov 2001 15:58:19 +0100
Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE> wrote:

> Russell King <rmk@arm.linux.org.uk> writes:
> 
> > |	* umount everything non-buys
>                             ^^^^^^^^
> 
> What does that mean?  It's a typo, isn't it?

It should be "non-busy" - i.e., everything that will let you umount it without
a "device is busy" error.

Bruce
