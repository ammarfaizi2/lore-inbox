Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129824AbQLNDlk>; Wed, 13 Dec 2000 22:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130125AbQLNDl3>; Wed, 13 Dec 2000 22:41:29 -0500
Received: from winds.org ([209.115.81.9]:34574 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S129824AbQLNDlR>;
	Wed, 13 Dec 2000 22:41:17 -0500
Date: Wed, 13 Dec 2000 22:10:50 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12 randomly hangs up
In-Reply-To: <200012132247.eBDMlM201139@lt.wsisiz.edu.pl>
Message-ID: <Pine.LNX.4.21.0012132205250.5935-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000, Lukasz Trabinski wrote:

> In article <20001213121349.A6787@sarah.kolej.mff.cuni.cz> you wrote:
> 
> > I can (re)confirm that. I work several hours on console without any
> > problem ... then I start X session and after several minutes system
> > hangs.
> 
> I can confirm that, too.
> Todaye, crashed two difference machines
> One: AMD-K6 3D, 300 MHz, RH 7.0 + updates, 64MB RAM
> Second one: AMD Athlon 600, 600MHz with, 128MB RAM, RH 7.0+updates
> 
> > Red Hat 7.0, XFree-3.3.6 (SVGA server), S3Virge/G2 (4MB)

I've been running 2.4.0-test12 patched with only the O_SYNC bug fix and I have
_not_ experienced any lockups on this machine.

Classic Athlon 825(750) MHz, 128MB Ram,
RH 7.0 based w/glibc 2.2, XFree-3.3.6 (S3 Trio 64 accel server), gcc 2.95.2

Not sure what the problem is yet... keep trying folks. :)

 -Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: bstanoszek@comtime.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
