Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289919AbSAPNQi>; Wed, 16 Jan 2002 08:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289922AbSAPNQ2>; Wed, 16 Jan 2002 08:16:28 -0500
Received: from pl100.nas921.ichikawa.nttpc.ne.jp ([210.165.234.100]:22825 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S289919AbSAPNQR>;
	Wed, 16 Jan 2002 08:16:17 -0500
Date: Wed, 16 Jan 2002 22:14:54 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Dave Jones <davej@suse.de>
Cc: e9625286@student.tuwien.ac.at, linux-kernel@vger.kernel.org
Subject: Re: floating point exception
Message-Id: <20020116221454.12e55709.bruce@ask.ne.jp>
In-Reply-To: <Pine.LNX.4.33.0201161257210.9083-100000@Appserv.suse.de>
In-Reply-To: <1011181530.513.0.camel@sector17.home.at>
	<Pine.LNX.4.33.0201161257210.9083-100000@Appserv.suse.de>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002 12:58:35 +0100 (CET)
Dave Jones <davej@suse.de> wrote:

> On 16 Jan 2002, Christian Thalinger wrote:
> 
> > I mentioned in my first mail the dual tyan, so athlon xp, no fpu
> > emulator ;-) and no oops messages.
> 
> Dual Athlon XP problem. Thanks for playing.

Interesting. That's the first actual report I've seen of problems caused by
using XPs instead of MPs. I'd been wondering if I could get away with XPs for
my next SMP box; now I know better ;)

