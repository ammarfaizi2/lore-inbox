Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287828AbSABOFj>; Wed, 2 Jan 2002 09:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287849AbSABOFd>; Wed, 2 Jan 2002 09:05:33 -0500
Received: from ns.suse.de ([213.95.15.193]:61966 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287828AbSABODi>;
	Wed, 2 Jan 2002 09:03:38 -0500
Date: Wed, 2 Jan 2002 15:03:33 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Robert Schwebel <robert@schwebel.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Jason Sodergren <jason@mugwump.taiga.com>,
        Anders Larsen <anders@alarsen.net>, <rkaiser@sysgo.de>
Subject: Re: [PATCH][RFC] AMD Elan patch
In-Reply-To: <Pine.LNX.4.33.0201021421090.3056-100000@callisto.local>
Message-ID: <Pine.LNX.4.33.0201021502160.427-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Family 4 Model 10 or so my information tells me. Unless there are also
> > others with the same name and different cpuid info.
> That's what /proc/cpuinfo says. Is there an instance where one can find
> the "official" families and model numbers? Something like a standard?

x86info is the closest thing to a complete list, but as hpa pointed out,
the problem identifying the cpu is easy, identifying the chipset is the
hard part.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

