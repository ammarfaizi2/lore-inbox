Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSFEMkV>; Wed, 5 Jun 2002 08:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315415AbSFEMkV>; Wed, 5 Jun 2002 08:40:21 -0400
Received: from [212.234.165.220] ([212.234.165.220]:28172 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S315406AbSFEMkU>; Wed, 5 Jun 2002 08:40:20 -0400
Date: Wed, 5 Jun 2002 13:40:29 +0200
To: Pavel Machek <pavel@suse.cz>
Cc: Russell King <rmk@arm.linux.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>,
        CPUfreq <cpufreq@www.linux.org.uk>
Subject: Re: [PATCH] cpufreq core for 2.5
Message-ID: <20020605114029.GR11474@poup.poupinou.org>
In-Reply-To: <20020602203510.A11542@flint.arm.linux.org.uk> <20020604153910.H36@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 03:39:11PM +0000, Pavel Machek wrote:
> Hi!
> 
> > +/*
> > + * cpufreq_max command line parameter.  Use:
> > + *  cpufreq=59000-221000
> > + * to set the CPU frequency to 59 to 221MHz.
> > + */
> 
> I guess this comment went out of date.

I am not sure, but I think this is for ARM arch.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
