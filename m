Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266767AbSKLOV6>; Tue, 12 Nov 2002 09:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266780AbSKLOV6>; Tue, 12 Nov 2002 09:21:58 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:18854 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266767AbSKLOV5>; Tue, 12 Nov 2002 09:21:57 -0500
Subject: Re: devfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Ian Molton <spyro@f2s.com>, Alexander Viro <viro@math.psu.edu>,
       xavier.bestel@free.fr,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021112104650.GA322@suse.de>
References: <1037094221.16831.21.camel@bip>
	<Pine.GSO.4.21.0211120445570.29617-100000@steklov.math.psu.edu>
	<20021112102535.1f94f50d.spyro@f2s.com>  <20021112104650.GA322@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Nov 2002 14:53:38 +0000
Message-Id: <1037112818.8313.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-12 at 10:46, Dave Jones wrote:
> On Tue, Nov 12, 2002 at 10:25:35AM +0000, Ian Molton wrote:
>  > > 	Again, WE ARE IN FEATURE FREEZE.
>  > And since when did feature freeze affect, as the guy said, *purely*
>  > userspace implementations?
> 
>  Since it would a *feature* to move it out of kernel space.
>  To reiterate : _FEATURE_ _FREEZE_. Nothing[1] new[2]
>  should be going into mainline at this point.

Who cares. You can do most of it already with hotplug and the remaining
bits are very much "oops should tell hotplug" bug fixes nothing more.

Alan

