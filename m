Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbREVLPf>; Tue, 22 May 2001 07:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261347AbREVLPZ>; Tue, 22 May 2001 07:15:25 -0400
Received: from ns.suse.de ([213.95.15.193]:61705 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S261325AbREVLPQ>;
	Tue, 22 May 2001 07:15:16 -0400
Date: Tue, 22 May 2001 13:15:15 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: David Weinehall <tao@acc.umu.se>
Cc: Steven Walter <srwalter@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Output of L1,L2 and L3 cache sizes to /proc/cpuinfo
In-Reply-To: <20010522064430.D4934@khan.acc.umu.se>
Message-ID: <Pine.LNX.4.30.0105221313150.19399-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2001, David Weinehall wrote:

> > > Wouldn't that be the same reason we have /anything/ in cpuinfo?
> > When /proc/cpuinfo was added, we didn't have /dev/cpu/*/cpuid
> > Now that we do, we're stuck with keeping /proc/cpuinfo for
> > compatability reasons.
>
> AFAIK, not all processors support cpuid.

Fair point, but as there was limited information available
from the CPU, the likelyhood of /proc/cpuinfo getting
extended further is somewhat unlikely.
Moreso if the feature can be accomplished equally as well
in userspace (Like the original post in this thread).


regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

