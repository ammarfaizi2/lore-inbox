Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132614AbRDXAZZ>; Mon, 23 Apr 2001 20:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132623AbRDXAZL>; Mon, 23 Apr 2001 20:25:11 -0400
Received: from mx1.sac.fedex.com ([199.81.208.10]:43015 "EHLO
	mx1.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S132614AbRDXAYg>; Mon, 23 Apr 2001 20:24:36 -0400
Date: Tue, 24 Apr 2001 08:25:07 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: axel <axel@rayfun.org>, <linux-kernel@vger.kernel.org>
Subject: Re: compile error 2.4.4pre6: inconsistent operand constraints in an
In-Reply-To: <E14rpIA-0000iK-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0104240820250.3738-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2001, Alan Cox wrote:

> 2.4.4pre6 only builds with gcc 2.96. If you apply the __builtin_expect fixes
> it builds and runs fine with 2.95. Not tried egcs. The gcc 3.0 asm constraints
> one I've yet to see a fix for.

So, should I upgrade to 2.96 from 2.95.3?

But, from http://gcc.gnu.org/gcc-2.96.html ...

   Please note that both GCC 2.96 and 2.97 are development versions; we
   do not recommend using them for production purposes. Binaries built
   using any version of GCC 2.96 or 2.97 will not be portable to systems
   based on one of our regular releases.


Does this still hold?

Thanks,
Jeff

