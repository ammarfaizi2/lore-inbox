Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314598AbSEBQCJ>; Thu, 2 May 2002 12:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314597AbSEBQCI>; Thu, 2 May 2002 12:02:08 -0400
Received: from holomorphy.com ([66.224.33.161]:46806 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314598AbSEBQCH>;
	Thu, 2 May 2002 12:02:07 -0400
Date: Thu, 2 May 2002 09:00:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502160047.GG32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E172isy-0001rL-00@starship> <20020502034318.T11414@dualathlon.random> <E172k3S-0001sH-00@starship> <20020502153402.A11414@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 03:34:02PM +0200, Andrea Arcangeli wrote:
> alpha is the same as mips I think. sparc would be the same too if
> there's any discontigmem sparc. Dunno of arm. We're talking about
> architectures needing discontigmem, 99% percent of users  doesn't need
> discontigmem in the first place, you never need discontigmem in x86 and
> even in new-numa you don't need discontigmem, you want to pass through
> discontigmem only to get the numa topology description that the current
> discontigmem provides via the pgdat.

Any chance you could name a few of these mysterious new NUMA machines?


Thanks,
Bill
