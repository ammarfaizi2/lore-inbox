Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284975AbRLKL1k>; Tue, 11 Dec 2001 06:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284972AbRLKL1a>; Tue, 11 Dec 2001 06:27:30 -0500
Received: from pl475.nas921.ichikawa.nttpc.ne.jp ([210.165.235.219]:42008 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S284970AbRLKL1U>;
	Tue, 11 Dec 2001 06:27:20 -0500
Date: Tue, 11 Dec 2001 20:27:07 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: John Huttley <john@mwk.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.16 Bug] major failure
Message-Id: <20011211202707.5abe3bed.bruce@ask.ne.jp>
In-Reply-To: <1008054620.1453.0.camel@albatross.hisdad.org.nz>
In-Reply-To: <1008054620.1453.0.camel@albatross.hisdad.org.nz>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Dec 2001 20:10:19 +1300
John Huttley <john@mwk.co.nz> wrote:

> 
> I wish to report a major failure.
> with 2.4.16 and 2.4.17-pre8
> on PII-450 x2 SMP system, Gigabyte BXDS board
> (has adaptec scsi chip on it)
> using IDE disk, scsi tape (DDS-4)
> 
> My system boots to X.
> I swap to VC1 and start tarring up a lot of mp3's.
> 
> It works fine if i leave it to complete.
> 
> If I go to X and then back to VC1, the system will lock solid.
> No num lock, no magic sysreq, no ping.

What video card are you using?

