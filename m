Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280978AbRLDQdf>; Tue, 4 Dec 2001 11:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280967AbRLDQdY>; Tue, 4 Dec 2001 11:33:24 -0500
Received: from mbr.sphere.ne.jp ([203.138.71.91]:60616 "EHLO mbr.sphere.ne.jp")
	by vger.kernel.org with ESMTP id <S278625AbRLDQdM>;
	Tue, 4 Dec 2001 11:33:12 -0500
Date: Wed, 5 Dec 2001 01:32:53 +0900
From: Bruce Harada <harada@mbr.sphere.ne.jp>
To: David Chow <davidchow@rcn.com.hk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbols of loop device
Message-Id: <20011205013253.767d2814.harada@mbr.sphere.ne.jp>
In-Reply-To: <1007476721.1790.0.camel@cm61-15-169-117.hkcable.com.hk>
In-Reply-To: <1007476721.1790.0.camel@cm61-15-169-117.hkcable.com.hk>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 Dec 2001 22:38:41 +0800
David Chow <davidchow@rcn.com.hk> wrote:

> Dear all,
> 
> Since 2.4.1x, I found I always got the following error? Why? I am using
> Redhat 7.2 stock standard. Why is that? I guess you people must have
> been using loop device correctly... Thanks.
> 
> 
> root]# modprobe loop
> /lib/modules/2.4.14/kernel/drivers/block/loop.o: unresolved symbol
> deactivate_page
 [SNIP]

"Redhat 7.2 stock standard" except for the kernel which you downloaded,
compiled, found didn't work and then complained about without checking the
list archives for messages from the ten thousand other people that had the
same problem as you.

Even a Google search on "unresolved symbol deactivate_page" would have told
you the answer.
