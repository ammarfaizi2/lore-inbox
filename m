Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287874AbSABSC6>; Wed, 2 Jan 2002 13:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287888AbSABSCs>; Wed, 2 Jan 2002 13:02:48 -0500
Received: from chiark.greenend.org.uk ([212.22.195.2]:25362 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S287883AbSABSCm>; Wed, 2 Jan 2002 13:02:42 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] Changing KB, MB, and GB to KiB, MiB, and GiB =?iso-8859-1?q?in	Configure=2Ehelp=2E?=
Newsgroups: chiark.mail.linux-rutgers.kernel
In-Reply-To: <a0133l$2ln$1@cesium.transmeta.com>
In-Reply-To: <3C234CC100020E25@mta13n.bluewin.ch> <by> <postmaster@bluewin.ch)> <200112220214.fBM2EsSr022402@svr3.applink.net>
Organization: Linux Unlimited
Message-Id: <E16Lpir-00055o-00@chiark.greenend.org.uk>
From: Jonathan Amery <jdamery@chiark.greenend.org.uk>
Date: Wed, 02 Jan 2002 18:02:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <a0133l$2ln$1@cesium.transmeta.com> you write:
>And all of us count that way.  Oh yes, the English unit is *so*
>attuned to nature... this is why we have different measures for dry
>volume, wet volume... avoirdupois versus troy weight... 
>oh yes, energy
>is measures in BTUs and power in horsepower... what is the conversion
>factor between them (it has the dimension of time?)

 I think you've just answered your previous question - there are more
than one because its generally more convenient.  If you're using
horsepower for power then you should probably be using
horsepower-hours rather than BTUs (which are an admittedly silly
unit for most things).

You have: horsepower hours
You want: btu
        * 2544.4336
        / 0.00039301478

>> Finally, Farhenheit units are smaller so that they make more convenient
>> divisions: Eg.
>Bullsh*t.  They seem more natural to you because you're more used to
>them.  Anyone who hasn't grown up on the system think that Fahrenheit
>is the ultimate in lunacy.

 Centigrade/Celcius have little to recomend them either - Kelvin is
the way forward, or Rankine.

 Jonathan.
