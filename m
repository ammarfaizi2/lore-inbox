Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262943AbREWBss>; Tue, 22 May 2001 21:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262944AbREWBsi>; Tue, 22 May 2001 21:48:38 -0400
Received: from ns.suse.de ([213.95.15.193]:13317 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262943AbREWBsW>;
	Tue, 22 May 2001 21:48:22 -0400
Date: Wed, 23 May 2001 03:48:21 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Martin Knoblauch <martin.knoblauch@teraport.de>
Cc: "H. Peter Anvin" <hpa@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
In-Reply-To: <3B0AFCFB.CAE7A145@teraport.de>
Message-ID: <Pine.LNX.4.30.0105230345440.22207-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2001, Martin Knoblauch wrote:

>  They may not be stupid, just mislead :-( When Intel created the "cpuid"
> Feature some way along the P3 line, they gave a stupid reason for it and
> created a big public uproar. As silly as I think that was (on both
> sides), the term "cpuid" is tainted. Some people just fear it like hell.
> Anyway.

I think you are confusing the CPU serial number with CPUID which is
not the same. CPUID instruction has been around since late 486en.

The P3 Serial number is still disabled by default in Linux,
unless overridden with a boottime switch.

regards,

Davej.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

