Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267354AbRGKRAl>; Wed, 11 Jul 2001 13:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267358AbRGKRAb>; Wed, 11 Jul 2001 13:00:31 -0400
Received: from ns.suse.de ([213.95.15.193]:38408 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S267354AbRGKRAO>;
	Wed, 11 Jul 2001 13:00:14 -0400
Date: Wed, 11 Jul 2001 19:00:10 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: Hugh Dickins <hugh@veritas.com>, Jordan <ledzep37@home.com>,
        Jordan Breeding <jordan.breeding@inet.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: Discrepancies between /proc/cpuinfo and Dave J's 
 x86info
In-Reply-To: <p05100361b77232f67994@[207.213.214.37]>
Message-ID: <Pine.LNX.4.30.0107111858110.1811-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2001, Jonathan Lundell wrote:

> HD's version has the advantage of not having to make assumptions
> about how future CPUs might handle the level, and leaves open the
> alternative possibility of leaving the level at 3 (or some future 4)
> and just turning off the serial-number capability.

Given the PR disaster that the P3 serial number brought about,
I'd be surprised if Intel were to revisit that chapter of history :)

I see your point however.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

