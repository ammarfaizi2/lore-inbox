Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314682AbSD1I0v>; Sun, 28 Apr 2002 04:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314683AbSD1I0u>; Sun, 28 Apr 2002 04:26:50 -0400
Received: from mbr.sphere.ne.jp ([210.150.254.228]:60628 "HELO
	mbr.sphere.ne.jp") by vger.kernel.org with SMTP id <S314682AbSD1I0t>;
	Sun, 28 Apr 2002 04:26:49 -0400
Date: Sun, 28 Apr 2002 17:26:47 +0900
From: Bruce Harada <harada@mbr.sphere.ne.jp>
To: "Ron Pagani / San Francisco / San Jose, CA" <lists@ronpagani.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.9,2.5.10 kernel compile, +SMP?
Message-Id: <20020428172647.231477e7.harada@mbr.sphere.ne.jp>
In-Reply-To: <F4439967-5A74-11D6-B3D0-0030657B7B46@ronpagani.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.6; i686-pc-linux-gnu)
X-Face: $qrUU,Lz=B[A}i%m2Rg^Ik;~V@]$Ay)$S`wUf3:^aZ1UdLf,_;1y7_xbEh=Yv*wB0=Fv]a1hj14_qQsl[f1KX]q4IdhwmSIeP6>Ap@[e$c$G;;ObLI7?Y<H5";4<{GAPoak2U)!da]-ZJb}!.#>Xsq*)M'3Jp<M,l~'4F{qWpM$%"%p'
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Apr 2002 23:55:41 -0700
"Ron Pagani / San Francisco / San Jose, CA" <lists@ronpagani.com> wrote:

> Folks:
> 
> Compile config question...
> 
> Single processor machine (Pentium III)
> 
> SMP comes default "ON" in my 2.5.10 and 2.5.9 config; why is it that if 
> I turn it off (since I'm only using one processor) the build breaks?  I 
> can post the part it chokes on (I recall something regarding 
> cpu_number)...
> 
> I this a broken config issue, or is someone/thing have a SMP dependency 
> in the 2.5 series?

make mrproper
