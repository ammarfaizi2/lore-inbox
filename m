Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287607AbSABOA4>; Wed, 2 Jan 2002 09:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287655AbSABOAq>; Wed, 2 Jan 2002 09:00:46 -0500
Received: from bs1.dnx.de ([213.252.143.130]:12264 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S287607AbSABOA1>;
	Wed, 2 Jan 2002 09:00:27 -0500
Date: Wed, 2 Jan 2002 14:49:11 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: Dave Jones <davej@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Jason Sodergren <jason@mugwump.taiga.com>,
        Anders Larsen <anders@alarsen.net>, <rkaiser@sysgo.de>
Subject: Re: [PATCH][RFC] AMD Elan patch
In-Reply-To: <Pine.LNX.4.33.0201020104140.26007-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.33.0201021421090.3056-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Dave Jones wrote:
> Family 4 Model 10 or so my information tells me. Unless there are also
> others with the same name and different cpuid info.

That's what /proc/cpuinfo says. Is there an instance where one can find
the "official" families and model numbers? Something like a standard?

The only thing I've found on the net is this:

  http://grafi.ii.pw.edu.pl/gbm/x86/cpuid.html#AuthenticAMD

Which doesn't list the ELANs. I couldn't also find something on AMD's
page.

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+



