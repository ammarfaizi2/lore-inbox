Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289037AbSAUEpu>; Sun, 20 Jan 2002 23:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289040AbSAUEpk>; Sun, 20 Jan 2002 23:45:40 -0500
Received: from pl100.nas921.ichikawa.nttpc.ne.jp ([210.165.234.100]:24616 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S289037AbSAUEp0>;
	Sun, 20 Jan 2002 23:45:26 -0500
Date: Mon, 21 Jan 2002 13:45:16 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
Message-Id: <20020121134516.503c40cd.bruce@ask.ne.jp>
In-Reply-To: <20020121044952.A21348@devcon.net>
In-Reply-To: <Pine.LNX.4.44.0201181632000.18867-100000@filesrv1.baby-dragons.com>
	<14160.1011396163@ocs3.intra.ocs.com.au>
	<20020121002041.B1958@idefix.fvdpol.home.nl>
	<20020121095458.2bd9c7ed.bruce@ask.ne.jp>
	<20020121044952.A21348@devcon.net>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002 04:49:52 +0100
Andreas Ferber <aferber@techfak.uni-bielefeld.de> wrote:

> On Mon, Jan 21, 2002 at 09:54:58AM +0900, Bruce Harada wrote:
> > 
> > ...and how would you guarantee that this setting remains set, in the face
> > of some nasty little cracker screwing around with /dev/kmem?
> 
> If the attacker gained the ability to play with /dev/kmem, he can
> already load modules into the kernel, regardless if the kernel is
> actually compiled with module support or not. You can find various
> papers describing how to do it via google, and AFAIK some rootkits are
> already using those techniques, so it's even "scriptkiddy-ready".

Er... that was exactly what I meant - perhaps you meant to reply to the parent
post?

