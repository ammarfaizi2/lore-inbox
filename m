Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264113AbRFLC14>; Mon, 11 Jun 2001 22:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264132AbRFLC1q>; Mon, 11 Jun 2001 22:27:46 -0400
Received: from biglinux.tccw.wku.edu ([161.6.10.206]:52447 "EHLO
	biglinux.tccw.wku.edu") by vger.kernel.org with ESMTP
	id <S264113AbRFLC12>; Mon, 11 Jun 2001 22:27:28 -0400
Date: Mon, 11 Jun 2001 21:27:06 -0500 (CDT)
From: "Brent D. Norris" <brent@biglinux.tccw.wku.edu>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3com Driver and the 3XP Processor
Message-ID: <Pine.LNX.4.30.0106112125280.9164-100000@biglinux.tccw.wku.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Kip for clarifying why Linux doesn't use this feature, but now I
wonder why you beleive this?


--hahn@coffee.psychology.mcmaster.ca-- wrote:

> > hype it does DES without using the CPU, does linux take advantage of that?
>
> no, as far as I've heard.  and I wouldn't expect it to either.
> further, it's highly questionable whether the feature makes sense...

If they release the API for it why would you not expect it to use it, and
why would getting a complex computation and encryption off of the CPU to a
more specialized hardware not make sense?

Brent Norris

Executive Advisor -- WKU-Linux




