Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266473AbSKLLBy>; Tue, 12 Nov 2002 06:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266478AbSKLLBy>; Tue, 12 Nov 2002 06:01:54 -0500
Received: from server0027.freedom2surf.net ([194.106.33.36]:56223 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id <S266473AbSKLLBx>; Tue, 12 Nov 2002 06:01:53 -0500
Date: Tue, 12 Nov 2002 11:08:34 +0000
From: Ian Molton <spyro@f2s.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: viro@math.psu.edu, xavier.bestel@free.fr, linux-kernel@vger.kernel.org
Subject: Re: devfs
Message-Id: <20021112110834.01e8f2da.spyro@f2s.com>
In-Reply-To: <20021112104650.GA322@suse.de>
References: <1037094221.16831.21.camel@bip>
	<Pine.GSO.4.21.0211120445570.29617-100000@steklov.math.psu.edu>
	<20021112102535.1f94f50d.spyro@f2s.com>
	<20021112104650.GA322@suse.de>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2002 10:46:50 +0000
Dave Jones <davej@codemonkey.org.uk> wrote:

> > And since when did feature freeze affect, as the guy said, *purely*
>  > userspace implementations?
> 
>  Since it would a *feature* to move it out of kernel space.
>  To reiterate : _FEATURE_ _FREEZE_. Nothing[1] new[2]
>  should be going into mainline at this point.

nothing new WOULD be going in. nor would devfs need to move out - just
disable it. It *is* still an option, is it not?

>  We should now be in the stabilising period, where we don't require
>  testers to have to upgrade their userspace every fortnight.

its not a kernel issue anymore, if its totally in userspace, is it?
