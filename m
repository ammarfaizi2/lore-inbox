Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSGUUYG>; Sun, 21 Jul 2002 16:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSGUUYG>; Sun, 21 Jul 2002 16:24:06 -0400
Received: from mbr.sphere.ne.jp ([210.150.254.228]:38373 "HELO
	mbr.sphere.ne.jp") by vger.kernel.org with SMTP id <S313305AbSGUUYF>;
	Sun, 21 Jul 2002 16:24:05 -0400
Date: Mon, 22 Jul 2002 05:27:10 +0900
From: Bruce Harada <harada@mbr.sphere.ne.jp>
To: michael@insulin-pumpers.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: build error when SMP = No
Message-Id: <20020722052710.4ad511b5.harada@mbr.sphere.ne.jp>
In-Reply-To: <200207202219.g6KMJvpK026242@ns2.is.bizsystems.com>
References: <200207202219.g6KMJvpK026242@ns2.is.bizsystems.com>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jul 2002 15:19:57 -0800
"Michael" <michael@insulin-pumpers.org> wrote:

> i86 based build of 
> 2.4.19-rc2
> 
> When 
> Symmetric multi-processing support (CONFIG_SMP) [Y/n/?] n
> 
> is Yes, everything builds fine.
> if No, the following fatal error occurs
> 
[SNIP]
> 
> Any joy out there??

make mrproper

