Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318764AbSIFQKR>; Fri, 6 Sep 2002 12:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318772AbSIFQKR>; Fri, 6 Sep 2002 12:10:17 -0400
Received: from sc-grnvl-66-169-5-131.chartersc.net ([66.169.5.131]:33207 "EHLO
	rhino") by vger.kernel.org with ESMTP id <S318764AbSIFQKP>;
	Fri, 6 Sep 2002 12:10:15 -0400
Subject: Re: ide drive dying?
From: Billy Harvey <Billy.Harvey@thrillseeker.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0209061141190.30387-100000@router.windsormachine.com>
References: <Pine.LNX.4.33.0209061141190.30387-100000@router.windsormachine.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Sep 2002 12:14:53 -0400
Message-Id: <1031328893.16365.243.camel@rhino>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-06 at 11:42, Mike Dresser wrote:
> On 6 Sep 2002, Alan Cox wrote:
> 
> > On Fri, 2002-09-06 at 16:26, Mike Dresser wrote:
> > > eBAY, and buy yourself a new drive.  You can pickup 80 gig drives for
> > > around 80 bucks nowadays.  I used to recommend Maxtors, until they said
> > > they're cutting their warranty to one year from three.  I don't know what
> > > to use anymore.
> >
> > At current drive density and reliabilities - raid. Software raid setups
> > are so cheap there is little point not running RAID on IDE nowdays
> >
> Well, I was looking more on the side of the Windows PC's here at the
> office, it's a bit expensive to start running raid on those.
> 
> Mike

Well, I haven't examined this empirically, but as the quantity of disk
drives in an organization continues increasing, so does the probability
of disk failure, any one of which can mean lost time/money, etc.  Drive
reliability is likely not increasing at the same rate that density is,
so the likelihood of lost data is probably increasing.  Since LAN speeds
continue to increase, it might start making sense now in clusters of
more than a few machines to make each machine less reliant on its own
disk storage (to the point of not at all other than big swap space) and
use the LAN more.  On the LAN put the money into a quality shared
resource - a heavy duty UPS'd, etc. RAID system.  Especially if a RAID
system is as easy to build/maintain/use as Alan alludes to (don't know -
never built one).

Billy

