Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288991AbSAUAzl>; Sun, 20 Jan 2002 19:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288992AbSAUAzb>; Sun, 20 Jan 2002 19:55:31 -0500
Received: from pl100.nas921.ichikawa.nttpc.ne.jp ([210.165.234.100]:14881 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S288991AbSAUAzV>;
	Sun, 20 Jan 2002 19:55:21 -0500
Date: Mon, 21 Jan 2002 09:54:58 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Frank van de Pol <fvdpol@home.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
Message-Id: <20020121095458.2bd9c7ed.bruce@ask.ne.jp>
In-Reply-To: <20020121002041.B1958@idefix.fvdpol.home.nl>
In-Reply-To: <Pine.LNX.4.44.0201181632000.18867-100000@filesrv1.baby-dragons.com>
	<14160.1011396163@ocs3.intra.ocs.com.au>
	<20020121002041.B1958@idefix.fvdpol.home.nl>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002 00:20:41 +0100
Frank van de Pol <fvdpol@home.nl> wrote:

> If you want to secure your box, why don't you simply put a lock on it and
> throw away the key? Really, what might help the paranoid admins in this case
> is a setting in the kernel which basically disables the ability to load or
> unload modules. Of course once set this setting can not been turned with
> rebooting the box.

...and how would you guarantee that this setting remains set, in the face of
some nasty little cracker screwing around with /dev/kmem?

