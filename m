Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131051AbQLHDWT>; Thu, 7 Dec 2000 22:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131187AbQLHDWJ>; Thu, 7 Dec 2000 22:22:09 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:25861 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131051AbQLHDV5>; Thu, 7 Dec 2000 22:21:57 -0500
Date: Thu, 7 Dec 2000 20:51:25 -0600
To: Rajiv Majumdar <rmajumda@tcg-software.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: related to pthread
Message-ID: <20001207205125.Q6567@cadcamlab.org>
In-Reply-To: <652569AE.0050738A.00@gemini.tcg-software.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <652569AE.0050738A.00@gemini.tcg-software.com>; from rmajumda@tcg-software.com on Thu, Dec 07, 2000 at 05:25:08PM +0530
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Rajiv Majumdar]
> during an exec it gives the following error message : "Pthread
> internal error : message : __libc__reinit() failed" and creates a
> core dump.

This is libc failing -- please report this through libc channels (see
http://www.gnu.org/software/libc).  If it is in fact a kernel bug I'm
sure they will forward it.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
