Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbRFPSa6>; Sat, 16 Jun 2001 14:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264645AbRFPSaj>; Sat, 16 Jun 2001 14:30:39 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:18150 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S264644AbRFPSa1>; Sat, 16 Jun 2001 14:30:27 -0400
Date: Sat, 16 Jun 2001 19:29:57 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: [Oops] 2.4.5-ac14/2.4.6-pre3+Athlon+gcc3-prerelease+VIAKT133A
Message-ID: <20010616192957.A2713@debian>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010616161801.A1821@caesar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010616161801.A1821@caesar>
User-Agent: Mutt/1.3.18i
From: Michael <leahcim@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2001 at 04:18:01PM +0800, Richard Chan wrote:
> Here's an oops from
> 
> 1. Athlon kernel, gcc3 prerelease 14 June compiled
> 2. Kernel version 2.4.5-ac14
> 3. Mobo: Soltek 75KAV (VT133A disaster??) with Athlon 1.2G C
> 
> Any ideas? Bad compiler or bad kernel?
> The problems occur in kmem_cache_????.
> 
> On this mobo and chipset I have had no luck with locally compiled
> Athlon kernels at all (whether stock or -ac, RedHat gcc or gcc3-prerelease).
> Me thinks something is seriously wrong with this mobo/chipset or is it
> the Athlon code in gcc?

FWIW, I've got 2 of these boards (with duron 800 chips) 

I use gcc2.95.4 in debian sid.

Got it about the same time the 686b patch went
into ac1 and its run flawlessly with every ac version I've used since.

Didn't compile ac14, went straight to 15.
-- 
Michael.
