Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261740AbSKLPbJ>; Tue, 12 Nov 2002 10:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSKLPbJ>; Tue, 12 Nov 2002 10:31:09 -0500
Received: from server0027.freedom2surf.net ([194.106.33.36]:4764 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S261740AbSKLPbI>; Tue, 12 Nov 2002 10:31:08 -0500
Date: Tue, 12 Nov 2002 15:37:42 +0000
From: Ian Molton <spyro@f2s.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davej@codemonkey.org.uk, viro@math.psu.edu, xavier.bestel@free.fr,
       linux-kernel@vger.kernel.org
Subject: Re: devfs
Message-Id: <20021112153742.7677c05b.spyro@f2s.com>
In-Reply-To: <1037112818.8313.32.camel@irongate.swansea.linux.org.uk>
References: <1037094221.16831.21.camel@bip>
	<Pine.GSO.4.21.0211120445570.29617-100000@steklov.math.psu.edu>
	<20021112102535.1f94f50d.spyro@f2s.com>
	<20021112104650.GA322@suse.de>
	<1037112818.8313.32.camel@irongate.swansea.linux.org.uk>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Nov 2002 14:53:38 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> >  Since it would a *feature* to move it out of kernel space.
> >  To reiterate : _FEATURE_ _FREEZE_. Nothing[1] new[2]
> >  should be going into mainline at this point.
> 
> Who cares. You can do most of it already with hotplug and the
> remaining bits are very much "oops should tell hotplug" bug fixes
> nothing more.

The more I think about this userspace devfs, the more I like it. simple,
clean, AND doesnt affect the kernel.

Pure coding beauty.
