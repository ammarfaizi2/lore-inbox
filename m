Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319155AbSIFQgr>; Fri, 6 Sep 2002 12:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319223AbSIFQgr>; Fri, 6 Sep 2002 12:36:47 -0400
Received: from windsormachine.com ([206.48.122.28]:266 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S319155AbSIFQgq>; Fri, 6 Sep 2002 12:36:46 -0400
Date: Fri, 6 Sep 2002 12:41:21 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Billy Harvey <Billy.Harvey@thrillseeker.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ide drive dying?
In-Reply-To: <1031328893.16365.243.camel@rhino>
Message-ID: <Pine.LNX.4.33.0209061226520.30387-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Sep 2002, Billy Harvey wrote:

> use the LAN more.  On the LAN put the money into a quality shared
> resource - a heavy duty UPS'd, etc. RAID system.  Especially if a RAID
> system is as easy to build/maintain/use as Alan alludes to (don't know -
> never built one).
>
> Billy

And don't forget the cost of cluebats to beat the users over the head
with.  I've been trying for 3 years to get people to save their documents
to the H: drive.  Still find stuff stored wherever they feel like storing
it.

So each facility has a backup server that nightly grabs their entire
drive, gzip's it, and then dumps it to a DDS-4 tape.  Also keeps X days of
daily full backups, and X weeks as well.

Aside from Windows filesharing being so slow(1500kps via smbtar is average
here), it works quite nicely.  Even with a P4/2.53, I still can't get
more than the 1500kps that a p133 is capable of.  All the p4 gives me, is
the ability to gzip -9 or even bzip2 the files, instead of the gzip -1
that the p133 is capable of in real time.

Mike

