Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268921AbRHBNR5>; Thu, 2 Aug 2001 09:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268923AbRHBNRr>; Thu, 2 Aug 2001 09:17:47 -0400
Received: from smtp1.bignet.net ([64.79.64.13]:27152 "EHLO smtp1.bignet.net")
	by vger.kernel.org with ESMTP id <S268921AbRHBNRb>;
	Thu, 2 Aug 2001 09:17:31 -0400
Date: Thu, 2 Aug 2001 09:15:18 -0400 (EDT)
From: "Joshua M. Thompson" <om@bignet.net>
To: "Paul G. Allen" <pgallen@randomlogic.com>
cc: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Dual Athlon, AGP, and PCI
In-Reply-To: <3B691B85.368D1BD0@randomlogic.com>
Message-ID: <Pine.LNX.4.33.0108020914070.17076-100000@darkstar.bignet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Paul G. Allen wrote:

> I've been dealing with both 2.4.7 and 2.4.2 kernels, but I have mainly
> been using 2.4.2 because I started with that before I realized 2.4.7 was
> available. I also have the NVidia driver, version 1.0-1251.
>
> [ snip ]
>
> mtrr: type mismatch for f8000000,4000000 old: write-back new:
> write-combining

Upgrade your kernel. 2.4.2 had broken mtrr support on Athlons.

-- 
Head Developer           | "...and we have C(n) = (n (n + 1))/ 2. Easy as pie.
Big Net, Inc.            |  Actually easier, Pi = Sum 8 / ((4n + 1)(4n + 3))."
                         |                   - Donald E. KNUTH

