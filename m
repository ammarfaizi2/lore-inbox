Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbUBGBAx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 20:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265686AbUBGBAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 20:00:53 -0500
Received: from mail.kroah.org ([65.200.24.183]:55253 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265655AbUBGBAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 20:00:51 -0500
Date: Fri, 6 Feb 2004 16:59:54 -0800
From: Greg KH <greg@kroah.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fbdev sysfs support.
Message-ID: <20040207005954.GB4492@kroah.com>
References: <Pine.LNX.4.44.0402070032030.19559-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402070032030.19559-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 12:34:29AM +0000, James Simmons wrote:
> 
> Linus, please do a
> 
> 	bk pull http://fbdev.bkbits.net/fbdev-2.6
> 
> This will update the following files:
> 
>  drivers/video/Makefile  |    2 
>  drivers/video/fbmem.c   |    6 ++
>  drivers/video/fbsysfs.c |  110 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fb.h      |   40 ++++++++++-------
>  4 files changed, 141 insertions(+), 17 deletions(-)
> 
> through these ChangeSets:
> 
> <jsimmons@infradead.org> (04/02/06 1.1549)
>    [FBDEV] Add syfs support.

Is there a patch anywhere to look at?

thanks,

greg k-h
