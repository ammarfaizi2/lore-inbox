Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279783AbRKVOxu>; Thu, 22 Nov 2001 09:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279805AbRKVOxk>; Thu, 22 Nov 2001 09:53:40 -0500
Received: from ns.suse.de ([213.95.15.193]:15880 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279783AbRKVOx0>;
	Thu, 22 Nov 2001 09:53:26 -0500
Date: Thu, 22 Nov 2001 15:53:20 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon /proc/cpuinfo anomaly [minor]
In-Reply-To: <Pine.LNX.4.33.0111221653290.28285-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.33.0111221552260.20788-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, Zwane Mwaikambo wrote:

> hmm i've always been under the impression that those strings are hard
> encoded into the CPU so even if we're on a motherboard/bios which doesn't
> "support" that particular CPU we can do a cpuid and get the same string.

It likely has a less descriptive hardware default, but it can be
(and is advised to be for bios writers) overridden in software.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

