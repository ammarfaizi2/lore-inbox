Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286721AbRLVIaJ>; Sat, 22 Dec 2001 03:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286723AbRLVI3z>; Sat, 22 Dec 2001 03:29:55 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:55534 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S286721AbRLVI3n>;
	Sat, 22 Dec 2001 03:29:43 -0500
Date: Sat, 22 Dec 2001 01:29:34 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Hello. Patch time (drivers/block/loop.c)
Message-ID: <20011222012934.B7823@lynx.no>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011222031442.A25275@grokthis.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011222031442.A25275@grokthis.net>; from ericw@grokthis.net on Sat, Dec 22, 2001 at 03:14:42AM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 22, 2001  03:14 -0500, Eric Windisch wrote:
> I may be looking at this and the multi-device drivers in the near
> future as I have a need for support for partitions on these devices;

Contact Neil Brown, as this is already done.  That is a "feature" of
Linux - most things you want to do have already been done by someone
else.

> I think it would be really neat if the software-raid could eventually
> become compatable with hardware raid.. although much slower

In many cases, software raid is as fast or faster than hardware raid.
What do you mean by "compatible"?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

