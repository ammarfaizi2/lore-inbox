Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSLJNqH>; Tue, 10 Dec 2002 08:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261663AbSLJNqH>; Tue, 10 Dec 2002 08:46:07 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:13584 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S261660AbSLJNqG>; Tue, 10 Dec 2002 08:46:06 -0500
Subject: Re: [BUG]: agpgart for i810 chipsets broken in 2.5.51
From: Antonino Daplas <adaplas@pol.net>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021210131143.GA26361@suse.de>
References: <1039522886.1041.17.camel@localhost.localdomain> 
	<20021210131143.GA26361@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 21:47:24 +0500
Message-Id: <1039538881.2025.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 18:11, Dave Jones wrote:
> On Tue, Dec 10, 2002 at 05:21:29PM +0500, Antonino Daplas wrote:
>  > 2.  The i810 driver for Xfree86 will also fail to load because of
>  > version mismatch (0.99 vs 1.0).  Rolling back the version corrects the
>  > problem.
> 
> Ugh, that's great. So X has to be patched every time the agpgart code
> gets a new revision ? That sounds really unpleasant.
> 
Actually, X is complaining that the kernel version was too old, crazy
no?

>  > No patches because I don't want to uglify the code :-)
> 
> I'll ping you when I have something to test.
> 
Ok.

Tony



