Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273328AbRINHYM>; Fri, 14 Sep 2001 03:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273329AbRINHYC>; Fri, 14 Sep 2001 03:24:02 -0400
Received: from c290168-a.stcla1.sfba.home.com ([24.250.174.240]:15692 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S273328AbRINHYA>; Fri, 14 Sep 2001 03:24:00 -0400
From: brian@worldcontrol.com
Date: Fri, 14 Sep 2001 00:25:58 -0700
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Cc: David Hollister <david@digitalaudioresources.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Conquering the Athlon optimization troubles
Message-ID: <20010914002558.A2046@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	Anton Altaparmakov <aia21@cus.cam.ac.uk>,
	David Hollister <david@digitalaudioresources.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3BA1472E.2000008@digitalaudioresources.org> <Pine.SOL.3.96.1010914012401.21012A-100000@virgo.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.3.96.1010914012401.21012A-100000@virgo.cus.cam.ac.uk>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 13 Sep 2001, David Hollister wrote:

> > My motherboard is the Epox 8KTA3+, and I'm running an Athlon 1.4GHz.
> > The point to all this is that with the newer BIOS, my machine is now
> > up and running absolutely fine with Athlon optimization turned on.

On Fri, Sep 14, 2001 at 01:28:45AM +0100, Anton Altaparmakov wrote:
> Maybe you meant 9/6/2001. That is the latest available version. From only
> 5 days ago. ...
> Congratulations! (-: I would recommend you to run a long memtest86 as well
> in particular tests 5 and 8. - They are the ones that used to fail for me
> with the inappropriate memmory settings...

I have an Epox 8KTA3+ Duron 900MHz system running linux 2.4.9ac5.
I oopses to death during boot of Athlon/Duron kernels, works fine
with K6 style kernels.

I flashed the BIOS with the 9/6/2001 BIOS upgrade, and the Athlon
optimized kernel dies in exactly the same way it did before.

-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2000 By Brian Litzinger, All Rights Reserved
