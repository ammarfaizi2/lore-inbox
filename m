Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289764AbSAJWlk>; Thu, 10 Jan 2002 17:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289756AbSAJWle>; Thu, 10 Jan 2002 17:41:34 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6417 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S289747AbSAJWkl>; Thu, 10 Jan 2002 17:40:41 -0500
Date: Thu, 10 Jan 2002 23:40:36 +0100
From: Pavel Machek <pavel@suse.cz>
To: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
Cc: Daniel Tuijnman <daniel@ATComputing.nl>, linux-kernel@vger.kernel.org
Subject: Re: Memory management problems in 2.4.16
Message-ID: <20020110224036.GA32522@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020109143434.A20955@ATComputing.nl> <Pine.LNX.4.33.0201090640080.13260-100000@shell1.aracnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201090640080.13260-100000@shell1.aracnet.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I installed a 2.4.16 kernel on a 486DX2-50 machine with 8MB memory and
> > 24MB swap and got insurmountable problems.
> 
> [snip]
> 
> > It seems to me that something definitely is wrong with the kernel's
> > memory management.
> 
> Well ... maybe *in theory* 2.4.16 should work on a machine with that
> little RAM but I'd say in practice Linux has simply outgrown your
> machine. Have you tried any other 2.4 kernels, say, before 2.4.10 when
> the VM changed?  Have you considered going to a garage sale and spending
> the local equivalent of $25 or $30 US for a more powerful computer?

8MB should be enough. I was running 2.4.0-test7 on 8MB machine with no
swap, because it had no disk to swap to.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
