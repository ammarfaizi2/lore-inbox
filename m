Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282243AbRKWVWd>; Fri, 23 Nov 2001 16:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282246AbRKWVWY>; Fri, 23 Nov 2001 16:22:24 -0500
Received: from pc-62-30-67-59-az.blueyonder.co.uk ([62.30.67.59]:22766 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S282243AbRKWVWK>; Fri, 23 Nov 2001 16:22:10 -0500
Date: Fri, 23 Nov 2001 21:19:14 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Tim Tassonis <timtas@cubic.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.15-greased-turkey ???
Message-ID: <20011123211914.B11439@kushida.jlokier.co.uk>
In-Reply-To: <Pine.LNX.4.33.0111230953240.1294-100000@penguin.transmeta.com> <Pine.LNX.4.40.0111231220590.6347-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0111231220590.6347-100000@waste.org>; from oxymoron@waste.org on Fri, Nov 23, 2001 at 12:29:18PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> I had to apply the following patch before I could run this on my system:
> 
> --- Makefile~	Thu Nov 22 13:22:58 2001
> +++ Makefile	Fri Nov 23 11:53:46 2001
> @@ -1,7 +1,7 @@
>  VERSION = 2
>  PATCHLEVEL = 4
>  SUBLEVEL = 15
> -EXTRAVERSION =-greased-turkey
> +EXTRAVERSION =-greased-tofurkey
> 
>  KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

I've had better luck with 2.4.15-tasteful-salad.

("offered their lives", indeed.  Why, I thought the USA's current
terminology was "collateral damage".)

-- Jamie
