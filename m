Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131941AbRCVIwN>; Thu, 22 Mar 2001 03:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131942AbRCVIvy>; Thu, 22 Mar 2001 03:51:54 -0500
Received: from [213.158.195.134] ([213.158.195.134]:49159 "EHLO
	plwawtl0.pl.ccbeverages.com") by vger.kernel.org with ESMTP
	id <S131941AbRCVIvw>; Thu, 22 Mar 2001 03:51:52 -0500
From: "Tomasz Sterna" <smoku@jaszczur.org>
Date: Thu, 22 Mar 2001 09:41:59 +0100
To: James Simmons <jsimmons@linux-fbdev.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: standard_io_resources[]
Message-ID: <20010322094159.A7407@plwawtl0.pl.ccbeverages.com>
In-Reply-To: <Pine.LNX.4.31.0103210908560.2648-100000@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0103210908560.2648-100000@linux.local>; from jsimmons@linux-fbdev.org on Wed, Mar 21, 2001 at 09:13:05AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2001 at 09:13:05AM -0800, James Simmons wrote:
> >Isn't that a job of the device drivers?
> Well most of those resources are present on every PC motherboard.

I still can't see a reason for allocating it before the device drivers 
could do that.

Any suggestions? Anyone?

> This will also be the case for 2.5.X. We already have the PS/2 keyboard
> ported over to the input api.

What is the "input api"? Could You give me any URL to read?


-- 
   __  ___   __
__`-,_( | )_(__)_|-<_(__)___ _
http://www.jaszczur.org/~smoku/
