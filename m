Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbVHSVKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbVHSVKl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbVHSVKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:10:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:15836 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965134AbVHSVKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:10:40 -0400
Date: Fri, 19 Aug 2005 14:10:25 -0700
From: Greg KH <greg@kroah.com>
To: Avuton Olrich <avuton@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1
Message-ID: <20050819211025.GB29476@kroah.com>
References: <20050819043331.7bc1f9a9.akpm@osdl.org> <3aa654a405081909427e033fd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa654a405081909427e033fd1@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 09:42:51AM -0700, Avuton Olrich wrote:
> On 8/19/05, Andrew Morton <akpm@osdl.org> wrote:
> > - Lots of fixes, updates and cleanups all over the place.
> 
> Problem: Badness during boot, seems to pertain to USB serial driver/gameport
> 
> Kernel Version: Linux version 2.6.13-rc6-mm1 (root@rocket) (gcc
> version 3.4.4 (Gentoo 3.4.4, ssp-3.4.4-1.0, pie-8.7.8)) #1 PREEMPT Fri
> Aug 19 09:14:10 PDT 2005
> 
> Could not duplicate this in 2.6.13-rc5-mm1

Does this happen in 2.6.13-rc6 (no -mm)?

I'm trying to reproduce this now (Andrew, I didn't have any such build
link errors like you did with this config...)

thanks,

greg k-h
