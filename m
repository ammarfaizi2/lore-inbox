Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSFDTy1>; Tue, 4 Jun 2002 15:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316662AbSFDTwq>; Tue, 4 Jun 2002 15:52:46 -0400
Received: from [195.39.17.254] ([195.39.17.254]:34975 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316664AbSFDTwe>;
	Tue, 4 Jun 2002 15:52:34 -0400
Date: Tue, 4 Jun 2002 15:39:11 +0000
From: Pavel Machek <pavel@suse.cz>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>,
        CPUfreq <cpufreq@www.linux.org.uk>
Subject: Re: [PATCH] cpufreq core for 2.5
Message-ID: <20020604153910.H36@toy.ucw.cz>
In-Reply-To: <20020602203510.A11542@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +/*
> + * cpufreq_max command line parameter.  Use:
> + *  cpufreq=59000-221000
> + * to set the CPU frequency to 59 to 221MHz.
> + */

I guess this comment went out of date.

								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

