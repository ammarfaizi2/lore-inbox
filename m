Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317326AbSHBVhH>; Fri, 2 Aug 2002 17:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317305AbSHBVhH>; Fri, 2 Aug 2002 17:37:07 -0400
Received: from holomorphy.com ([66.224.33.161]:17859 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317286AbSHBVhG>;
	Fri, 2 Aug 2002 17:37:06 -0400
Date: Fri, 2 Aug 2002 14:40:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rmap speedup
Message-ID: <20020802214012.GJ25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
References: <E17aiJv-0007cr-00@starship> <3D4AE995.DFD862EF@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D4AE995.DFD862EF@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 01:20:37PM -0700, Andrew Morton wrote:
> Sigh.  I have a test which sends the 2.5.30 VM into a five-minute
> coma and which immediately panics latest -ac with pte_chain oom.
> Remind me again why all this is worth it?
> I'll port your stuff to 2.5 over the weekend, let you know...

I wrote the test (or is this the one I wrote?), I'll fix it. I've
already arranged to sleep in the right places.


Cheers,
Bill
