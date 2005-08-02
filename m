Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVHBNL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVHBNL2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 09:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVHBNL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 09:11:27 -0400
Received: from pop-canoe.atl.sa.earthlink.net ([207.69.195.66]:40911 "EHLO
	pop-canoe.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S261509AbVHBNKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 09:10:46 -0400
Message-ID: <42EF70BD.7070804@earthlink.net>
Date: Tue, 02 Aug 2005 09:10:21 -0400
From: Stephen Clark <stephen.clark@earthlink.net>
Reply-To: sclark46@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bruce <bruce@andrew.cmu.edu>
CC: "Theodore Ts'o" <tytso@mit.edu>, David Weinehall <tao@acc.umu.se>,
       Lee Revell <rlrevell@joe-job.com>, Pavel Machek <pavel@ucw.cz>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
References: <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz> <1122852234.13000.27.camel@mindpipe> <20050801074447.GJ9841@khan.acc.umu.se> <42EE4B4A.80602@andrew.cmu.edu> <20050801204245.GC17258@thunk.org> <42EEFB9B.10508@andrew.cmu.edu>
In-Reply-To: <42EEFB9B.10508@andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bruce wrote:

>Theodore Ts'o wrote:
> > On Mon, Aug 01, 2005 at 12:18:18PM -0400, James Bruce wrote:
> >>The tradeoff is a realistic 4.4% power savings vs a 300% increase in
> >>the minimum sleep period.  A user will see zero power savings if they
> >>have a USB mouse (probably 99% of desktops).  On top of that, we can
>                                     ^^^^^^^^
>
> > Most laptops (including mine, a Thinkpad T40) use a PS/2 mouse.  So in
> > the places where power consumption savins matters most, it's usually
> > quite possible to function without needing any USB devices.  The 90%
> > figure isn't at all right; in fact, it may be that over 90% of the
> > laptops still use PS/2 mice and keyboards.
>
>Yes, laptops are mostly PS/2, which is why I only claimed a statistic 
>for desktops.  Desktops pretty much all use USB mice now.  If 250Hz were 
>only being sold as an option for laptops, we could leave it at that, yet 
>its being pushed as a default that's "good for everyone".  For desktops 
>this is not currently true at all.  By the time USB is fixed to do power 
>saving, we'll probably have a working tick-skipping patch which makes 
>the whole HZ argument moot.
>
>  - Jim Bruce
>
>  
>
Maybe new desktop systems - but what about the tens of millions of old 
systems that don't.

Steve
