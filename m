Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272522AbRISShW>; Wed, 19 Sep 2001 14:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274134AbRISShM>; Wed, 19 Sep 2001 14:37:12 -0400
Received: from mail.ask.ne.jp ([203.179.96.3]:3806 "EHLO mail.ask.ne.jp")
	by vger.kernel.org with ESMTP id <S272522AbRISShB>;
	Wed, 19 Sep 2001 14:37:01 -0400
Date: Thu, 20 Sep 2001 03:38:41 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Locked up 2.4.10-pre11 on Tyan 815t motherboard.
Message-Id: <20010920033841.2079e414.bruce@ask.ne.jp>
In-Reply-To: <3BA8DF59.B9F536B4@candelatech.com>
In-Reply-To: <3BA84088.27698798@candelatech.com>
	<3BA8CCF1.CA2933B3@zip.com.au>
	<3BA8D351.F57BE70D@candelatech.com>
	<3BA8D619.9A607219@zip.com.au>
	<3BA8DF59.B9F536B4@candelatech.com>
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001 11:09:29 -0700
Ben Greear <greearb@candelatech.com> wrote:
>
> When I opened the machine the first time (before I powered it up),
> I noticed that the CPU fan's wires were tangled in the fan such that
> it couldn't move..  I fixed that, but it could have been run before
> I received the machine...  Could that cause this problem you think??

Doubtful. Since it's an 815, I presume you're running a PIII (correct me if
I'm wrong) - newish PIIIs have reasonable overheating cutout features, and
if overheating had damaged the CPU, I'd be very surprised if it worked at
all, rather than just locking up on certain sizes of network packets.

