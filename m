Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbUBTRKU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 12:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUBTRKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 12:10:19 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:46059 "HELO
	trinity-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S261346AbUBTRKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 12:10:13 -0500
X-qfilter-stat: ok
X-Analyze: Velop Mail Shield v0.0.4
Date: Fri, 20 Feb 2004 14:10:09 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: Nico Schottelius <nico-kernel@schottelius.org>
cc: Bruce Allen <ballen@gravity.phys.uwm.edu>, linux-kernel@vger.kernel.org
Subject: Re: harddisk or kernel problem?
In-Reply-To: <20040219081642.GE25184@schottelius.org>
Message-ID: <Pine.LNX.4.58.0402201407480.1167@pervalidus.dyndns.org>
References: <Pine.GSO.4.21.0402181039520.8134-100000@dirac.phys.uwm.edu>
 <Pine.LNX.4.58.0402182002180.11305@brain.fop.ns.ca> <20040219081642.GE25184@schottelius.org>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004, Nico Schottelius wrote:

> Steve Bromwich [Wed, Feb 18, 2004 at 08:06:47PM -0400]:
> > On Wed, 18 Feb 2004, Bruce Allen wrote:
> >
> > > > 194 Temperature_Celsius     0x0022   100   050   000    Old_age   Always
> > > > -       48 (Lifetime Min/Max 14/65)
> > > >
> > > > If I'm reading this correctly, you've been running the drive when it's
> > > > extremely cold and extremely hot (Min/Max 14/65, I'm guessing that's
> > > > either Fahrenheit or a raw unconverted reading from the thermistor).
> > >
> > > Neither.  Fujitsu uses Celsuis: 14, 48, and 65 are all in Celsuis.
> >
> > Good grief... I'm not surprised the drive's dying, then! I've seen drives
> > lock up around 35C, I'm quite impressed the drive is still chugging along
> > (to some extent, at least) at 48C - and a max of 65C? Looking at a few of
> > Fujitsu's pages (eg,
> > http://www.fujitsu.ca/products/mobile_hdd/mht_ah/physical_specs.html),
> > ambient operating temperature is 5C to 55C - perhaps that's the cause of
> > the drive dying?
> >
> > Just out of curiosity, Nico, what're you doing with these drives that
> > they're running so hot?
>
> You won't believe it.
> It ran in a standard ECS Elitebook A530 Notebook.
> I always waited some time (30 Minutes up to some hours), when it was
> cold outside.
> I am working with this laptop about 10-20 hours a day, it runs several
> compile runs, etc.

It isn't that hot, and by ambient temperature I assume it's the
local temperature, not of the hard drive.

194 Temperature_Celsius     0x0022   079   074   042    Old_age   Always       -       54

and has been running almost fine for over 2 years.

-- 
http://www.pervalidus.net/contact.html
