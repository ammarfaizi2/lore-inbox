Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293187AbSDCHFO>; Wed, 3 Apr 2002 02:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293204AbSDCHEy>; Wed, 3 Apr 2002 02:04:54 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:1299 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S293187AbSDCHEm>; Wed, 3 Apr 2002 02:04:42 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: [PATCH] bitops cleanup 3/4 
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: Your message of "Tue, 02 Apr 2002 23:08:47 MST."
             <200204030608.g3368l903461@vindaloo.ras.ucalgary.ca> 
Date: Wed, 03 Apr 2002 16:29:04 +1000
Message-Id: <E16seGa-0008NA-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200204030608.g3368l903461@vindaloo.ras.ucalgary.ca> you write:
> Rusty Russell writes:
> > Linus, please apply (no object code changes).
> > 
> > This changes everything arch specific PPC and i386 which should have
> > been unsigned long (it doesn't *matter*, but bad habits get copied).
> > 
> > I left the devfs ones for Richard to submit separately, since they
> > actually change the resulting code.
> 
> ??? But you didn't leave the devfs ones alone: your patch changes a
> devfs file:

Sorry, my slip on dividing up the patches.  It doesn't make a
difference if that bit gets applied now anyway.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
