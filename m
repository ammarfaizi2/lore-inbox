Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbWBARv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWBARv2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 12:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbWBARv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 12:51:27 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:3201 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1030392AbWBARv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 12:51:27 -0500
Date: Wed, 1 Feb 2006 12:51:25 -0500
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-ID: <20060201175125.GG18972@csclub.uwaterloo.ca>
References: <OFA0FDB57C.2E4B1B4D-ON88257103.00688AE2-88257103.0069EF1C@us.ibm.com> <200601311856.17569.a1426z@gawab.com> <986ed62e0601312006y75748bd9x8925556e979d59c9@mail.gmail.com> <200602010951.08967.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602010951.08967.andrew@walrond.org>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 09:51:08AM +0000, Andrew Walrond wrote:
> In the not-too-distant future, there is likely to be a ram/disk price 
> inversion; ram becomes cheaper/mb than disk. At that point, we'll be buying 
> hardware based on "how much disk can I afford to provide power-off backup of 
> my ram?" rather than "how much ram can I afford?"

Hmm...

I resently bought a 250GB HD for my machine for $112, which is $0.50/GB
or $0.0005/MB.  I bought 512M ram for $55. which is $0.10/MB.  The ram
cost 200 times more per MB than the disk space.

In 1992 I got a 245MB HD for a new machine for $500 as far as I recall,
which was $2/MB.  I got 16MB ram for $800, which was $50/MB.  The ram
cost 25 times more than the disk space.

So just what kind of price trend are you looking at that will let you
get ram cheaper than disk space any time soon?  There has never been
such a trend yet as far as I know.  Maybe you have better data than me.
My experience shows the other direction.  Both memory and disk space are
much cheaper than they used to be, but the disk space has reduced in
price much faster than memory.

> At that point, things will change.

Sure, except I don't believe it will ever happen.

> Maybe, then, everything _will_ be in ram (with the kernel will intelligently 
> write out pages to the disk in the background, incase of power failure and 
> ready for a shutdown). Disk reads only ever occur during a power-on 
> population of ram.

Len Sorensen
