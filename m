Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131187AbQLHDaU>; Thu, 7 Dec 2000 22:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131850AbQLHDaL>; Thu, 7 Dec 2000 22:30:11 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:1757 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131187AbQLHD3u>;
	Thu, 7 Dec 2000 22:29:50 -0500
Date: Thu, 7 Dec 2000 21:59:18 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: aeb@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: [patch-2.4.0-test12-pre6] truncate(2) permissions
In-Reply-To: <UTC200012080235.DAA157231.aeb@aak.cwi.nl>
Message-ID: <Pine.GSO.4.21.0012072156420.22281-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Dec 2000 Andries.Brouwer@cwi.nl wrote:

> > BTW, if you still have 1.7, 1.10, 1.13 and 1.14...
> 
> See ftp://ftp.cwi.nl/pub/aeb/manpages/ (will soon disappear again).

Got them, thanks.

> > BTW, could we finally lose mpx(2)?
> 
> Maybe we lost it - I find sys_mpx only in a comment in arch/arm/kernel/calls.S

Sure, but man2/mpx.2 is alive and well...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
