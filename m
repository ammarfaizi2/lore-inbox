Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267056AbUBSIRI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 03:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267052AbUBSIQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 03:16:54 -0500
Received: from ns.schottelius.org ([213.146.113.242]:25003 "HELO
	ns.schottelius.org") by vger.kernel.org with SMTP id S267057AbUBSIQk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 03:16:40 -0500
Date: Thu, 19 Feb 2004 09:16:42 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Steve Bromwich <kernel@fop.ns.ca>
Cc: Bruce Allen <ballen@gravity.phys.uwm.edu>, linux-kernel@vger.kernel.org
Subject: Re: harddisk or kernel problem?
Message-ID: <20040219081642.GE25184@schottelius.org>
References: <Pine.GSO.4.21.0402181039520.8134-100000@dirac.phys.uwm.edu> <Pine.LNX.4.58.0402182002180.11305@brain.fop.ns.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402182002180.11305@brain.fop.ns.ca>
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux bruehe 2.6.1
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Bromwich [Wed, Feb 18, 2004 at 08:06:47PM -0400]:
> On Wed, 18 Feb 2004, Bruce Allen wrote:
> 
> > > 194 Temperature_Celsius     0x0022   100   050   000    Old_age   Always
> > > -       48 (Lifetime Min/Max 14/65)
> > >
> > > If I'm reading this correctly, you've been running the drive when it's
> > > extremely cold and extremely hot (Min/Max 14/65, I'm guessing that's
> > > either Fahrenheit or a raw unconverted reading from the thermistor).
> >
> > Neither.  Fujitsu uses Celsuis: 14, 48, and 65 are all in Celsuis.
> 
> Good grief... I'm not surprised the drive's dying, then! I've seen drives
> lock up around 35C, I'm quite impressed the drive is still chugging along
> (to some extent, at least) at 48C - and a max of 65C? Looking at a few of
> Fujitsu's pages (eg,
> http://www.fujitsu.ca/products/mobile_hdd/mht_ah/physical_specs.html),
> ambient operating temperature is 5C to 55C - perhaps that's the cause of
> the drive dying?
> 
> Just out of curiosity, Nico, what're you doing with these drives that
> they're running so hot?

You won't believe it.
It ran in a standard ECS Elitebook A530 Notebook. 
I always waited some time (30 Minutes up to some hours), when it was
cold outside.
I am working with this laptop about 10-20 hours a day, it runs several
compile runs, etc.

Mostly the same things I did on my Acer Travelmate..well this hard disk
died, too..

Well, currently I am wondering why two disks died, too.

Sincerly,

Nico
