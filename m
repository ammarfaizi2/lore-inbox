Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315480AbSE2U4v>; Wed, 29 May 2002 16:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSE2U4u>; Wed, 29 May 2002 16:56:50 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:35844 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315480AbSE2U4t>; Wed, 29 May 2002 16:56:49 -0400
Date: Wed, 29 May 2002 22:56:45 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Diego Calleja <DiegoCG@teleline.es>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.18, pdflush 100% cpu utilization
Message-ID: <20020529205645.GB1397@louise.pinerecords.com>
In-Reply-To: <20020525212512.7a14d1d9.DiegoCG@teleline.es> <20020526094648.GA15233@louise.pinerecords.com> <20020527090123.A69@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: GNU/Linux 2.4.19-pre9 SMP
X-Architecture: sparc
X-Uptime: 49 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Kernel Panic: pse required
> >                 ^^^
> > 
> > $ cat /proc/cpuinfo
> > kala@kirsi:~$ cat /proc/cpuinfo| grep flags
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
> >                              ^^^
> 
> You wanted to explain third person what PSE is, or you got that panic on machine
> that does have pse?

I was merely pointing out that swsusp itself reported that PSE was required.

T.
