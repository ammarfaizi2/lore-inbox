Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUEWJLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUEWJLo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 05:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUEWJLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 05:11:44 -0400
Received: from pa103.nowa-wies.sdi.tpnet.pl ([213.77.149.103]:11021 "EHLO
	pa103.nowa-wies.sdi.tpnet.pl") by vger.kernel.org with ESMTP
	id S262406AbUEWJLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 05:11:42 -0400
Date: Sun, 23 May 2004 11:11:21 +0200 (CEST)
From: Jan Meizner <jm@pa103.nowa-wies.sdi.tpnet.pl>
To: John Bradford <john@grabjohn.com>
Cc: system <system@eluminoustechnologies.com>, linux-kernel@vger.kernel.org
Subject: Re: hda Kernel error!!!
In-Reply-To: <200405221622.i4MGMuhD000211@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.55L.0405231054250.20096@pa103.nowa-wies.sdi.tpnet.pl>
References: <200405221257.28570.system@eluminoustechnologies.com>
 <Pine.LNX.4.55L.0405221515410.32669@pa103.nowa-wies.sdi.tpnet.pl>
 <200405221622.i4MGMuhD000211@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 22 May 2004, John Bradford wrote:

> Quote from Jan Meizner <jm@pa103.nowa-wies.sdi.tpnet.pl>:
> > 
> > 
> > > WARNING:  Kernel Errors Present
> > >    hda: drive_cmd: error=0x04 { DriveStat...:  1Time(s)
> > >    hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }...:  1Time(s)
> > > 
[...]
> > So AFAIK this type of error indicates serious problem with hardware, 
> > unfortunately.
> 
> It does not necessarily indicate a serious problem.  Are you sure your
> error messages were exactly the same?
Probably you're right. I should rather say it might be an error. I had 
similar error (i couldn't found log now) but it may differ a bit, and I 
also get some additional errors (I/O errors).

BTW maybe somebody have similar problem. Unfortunately it's not my machine 
so I cannot do any test other then looking at dmesg. There is kernel 
2.4.26. When my friend try to use put there his hard drive (old Segate 
8GB) it get during boot, or while trying to acces drive (depend on which 
computer he tries) 4 times CRC Error and machine complitly freeze (don't 
react on anything, no opps, no panic).
When I tried to use my Segate (3.2GB) i got lost interupt errors at boot 
time.

Both drives are ok (I've checked them).

If somebody have any idea what the problem is, I would be very grateful 
for advice. I could provide specyfic drive types later if it makes any 
sens.

Best Regards
Jan Meizner
