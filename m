Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316902AbSE1UiO>; Tue, 28 May 2002 16:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316903AbSE1Uh4>; Tue, 28 May 2002 16:37:56 -0400
Received: from [195.39.17.254] ([195.39.17.254]:57756 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316902AbSE1Uhw>;
	Tue, 28 May 2002 16:37:52 -0400
Date: Mon, 27 May 2002 09:01:23 +0000
From: Pavel Machek <pavel@suse.cz>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Diego Calleja <DiegoCG@teleline.es>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.18, pdflush 100% cpu utilization
Message-ID: <20020527090123.A69@toy.ucw.cz>
In-Reply-To: <20020525212512.7a14d1d9.DiegoCG@teleline.es> <20020526094648.GA15233@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Kernel Panic: pse required
>                 ^^^
> 
> $ cat /proc/cpuinfo
> kala@kirsi:~$ cat /proc/cpuinfo| grep flags
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
>                              ^^^

You wanted to explain third person what PSE is, or you got that panic on machine
that does have pse?
									Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

