Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282688AbRLKTMb>; Tue, 11 Dec 2001 14:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282668AbRLKTML>; Tue, 11 Dec 2001 14:12:11 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:30620 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S282525AbRLKTMF>; Tue, 11 Dec 2001 14:12:05 -0500
Date: Tue, 11 Dec 2001 12:11:58 -0700
Message-Id: <200112111911.fBBJBw404510@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Devfs and raw devices
In-Reply-To: <20011211184642.GB1123@dardhal.mired.net>
In-Reply-To: <1008026021.2388.3.camel@tiger>
	<20011211184642.GB1123@dardhal.mired.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jdomingo@internautas.org writes:
> On Monday, 10 December 2001, at 18:13:40 -0500,
> Louis Garcia wrote:
> 
> > Is their any reason raw devices are not supported by devfs? Is it that no
> > one has bothered with implementation.
> > 
> Somebody sent a patch to support raw devices on devfs a couple of days
> ago. Search the list archives and it should be there. As far as I know,
> Richard Gooch hasn't integrated this code into devfs yet.

Huh? Every time someone has asked about this, I've said "good idea,
code it up and send a patch to Linus/Marcelo". I don't want to deal
with pushing this into the kernel, I'm having enough trouble getting
Linus to apply the current batch of devfs fixes.

As long as I'm in the loop somewhere, just to do a sanity check, I'm
satisfied. I don't have an overwhelming urge to maintain various devfs
patches for drivers. Been there, done that :-(
I'm even willing to sprinkle my own unholy penguin pee on a patch if
someone thinks (wrongly:-) that it will help get it applied. You can't
ask for more than that, right? (OK, you can, but you won't get it:-).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
