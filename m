Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRAaK0m>; Wed, 31 Jan 2001 05:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbRAaK0d>; Wed, 31 Jan 2001 05:26:33 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:5386 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129485AbRAaK0W>; Wed, 31 Jan 2001 05:26:22 -0500
Date: Wed, 31 Jan 2001 04:26:17 -0600
To: Tom Leete <tleete@mountain.net>
Cc: David Ford <david@linux.com>, Stephen Frost <sfrost@snowman.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
Message-ID: <20010131042616.A32636@cadcamlab.org>
In-Reply-To: <3A777E1A.8F124207@linux.com> <20010130220148.Y26953@ns> <3A77966E.444B1160@linux.com> <3A77C6E7.606DDA67@mountain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A77C6E7.606DDA67@mountain.net>; from tleete@mountain.net on Wed, Jan 31, 2001 at 03:03:51AM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Tom Leete]
> It's not an incompatibility with the k7 chip, just bad code in
> include/asm-i386/string.h.

So you're saying SMP *is* supported on Athlon?  Do motherboards exist?

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
