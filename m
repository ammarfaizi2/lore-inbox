Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbUK2Myc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUK2Myc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUK2Mxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:53:31 -0500
Received: from unthought.net ([212.97.129.88]:58275 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261704AbUK2MvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:51:10 -0500
Date: Mon, 29 Nov 2004 13:51:07 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: raid1 oops in 2.6.9 (debian package 2.6.9-1-686-smp)
Message-ID: <20041129125106.GY4469@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
References: <20041128142840.GA4119@mur.org.uk> <20041129100707.GX4469@unthought.net> <20041129120259.GA23970@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129120259.GA23970@middle.of.nowhere>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 01:02:59PM +0100, Jurriaan wrote:
> From: Jakob Oestergaard <jakob@unthought.net>
> Date: Mon, Nov 29, 2004 at 11:07:08AM +0100
> > Why oh why, do we need raid10 ?
> 
> Raid-10 allows things currently not possible with raid-0/raid-1, like
> spreading 2 pieces of data over 3 pieces of harddisk.

Sounds weird to me, but hey, that's probably just me :)

> 
> Their was an introductory message on the linux-raid mailinglist, but
> it's more than one month old so I don't have a local copy.

I must have missed it when I looked for it then - I'll look again.

Thanks!

> 
> > And; if raid10 does not provide new functionality that was not possible
> > with raid1 + raid0, why oh why does this get accepted in a stable kernel
> > series? 
> 
> New drivers that are not enabled by default have always been allowed in
> stable kernels, since they don't have an impact on stability for the
> average user.

True

-- 

 / jakob

