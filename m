Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317408AbSGDNbU>; Thu, 4 Jul 2002 09:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317409AbSGDNbT>; Thu, 4 Jul 2002 09:31:19 -0400
Received: from pl425.nas921.ichikawa.nttpc.ne.jp ([210.165.235.169]:47130 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S317408AbSGDNbT>;
	Thu, 4 Jul 2002 09:31:19 -0400
Date: Thu, 4 Jul 2002 22:33:47 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Kareem Dana <kareemy@earthlink.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SiS645DX Chipset and agpgart support
Message-Id: <20020704223347.5f591c6a.bruce@ask.ne.jp>
In-Reply-To: <20020703133829.738c63cd.kareemy@earthlink.net>
References: <20020703133829.738c63cd.kareemy@earthlink.net>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2002 13:38:29 -0400
Kareem Dana <kareemy@earthlink.net> wrote:

> When my kernel boots up it complains "Unsupported SiS chipset (device id:
> 0646), you might want to try agp_try_unsupported=1. no supported devices
> found."
> 
> Is the 645dx chipset completely unsupported? It is fairly popular. I believe
> it uses the same agp controller as the regular sis 645. Is that unsupported
> as well?

Have you tried entering agp_try_unsupported=1 at the boot prompt, as the
message suggested?

