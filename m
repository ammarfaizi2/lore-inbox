Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAYDDQ>; Wed, 24 Jan 2001 22:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAYDDG>; Wed, 24 Jan 2001 22:03:06 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:18701 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S129383AbRAYDCw>; Wed, 24 Jan 2001 22:02:52 -0500
Message-Id: <200101250302.f0P32Qs05525@aslan.scsiguy.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Leslie Donaldson <donaldlf@hermes.cs.rose-hulman.edu>
cc: Jeff Hartmann <jhartmann@valinux.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org,
        John Mifsud <john.mifsud@au.interpath.net>,
        Gregory McLean <gregm@comstar.net>, Armin Obersteiner <armin@xos.net>
Subject: Re: Patch for aic7xxx 2.4.0 test12 hang 
In-Reply-To: Your message of "Sun, 21 Jan 2001 23:30:13 CST."
             <3A6BC565.2EE6E268@mailhost.cs.rose-hulman.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 24 Jan 2001 20:02:26 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello all,
>  I included everyone (boy + dog) so everyone knows the result.
>
> After much testing here is the results. I used the following patch
>
> linux-aic7xxx-6.0.9BETA-2.4.0.diffs
>
> against the ne 2.4.0 kernel sans my patch and happy to report it
> cleaned up the TCQ problem.

Thanks for the positive report!

I can't say exactly what kernel release will have the new driver
in it, but work is well underway toward making that happen.

--
Justin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
