Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTEGADp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 20:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTEGADp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 20:03:45 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:43205 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261957AbTEGADo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 20:03:44 -0400
Date: Tue, 6 May 2003 17:17:55 -0700
From: Greg KH <greg@kroah.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Frank Davis <fdavis@si.rr.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       Ronald Bultje <R.S.Bultje@pharm.uu.nl>
Subject: Re: [patch] i2c #1/3: listify i2c core
Message-ID: <20030507001755.GA4441@kroah.com>
References: <20030506193430.GA865@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506193430.GA865@bytesex.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 09:34:30PM +0200, Gerd Knorr wrote:
>   Hi,
> 
> This is the first of tree patches for i2c.  Trying to get the i2c
> cleanups finshed before 2.6.x, so we (hopefully) don't have a
> ever-changing i2c subsystem in 2.7.x again (which is very annonying for
> driver maintainance).

Thanks for the patches, I've applied all three to my tree, and fixed up
a small compile error if DEBUG is enabled.  I'll send them all on to
Linus in a bit, with some other i2c changes.

thanks,

greg k-h
