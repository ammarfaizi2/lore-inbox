Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUBZOnS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 09:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbUBZOnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 09:43:18 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:10471 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S261611AbUBZOnN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 09:43:13 -0500
Date: Thu, 26 Feb 2004 07:43:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH][1/3] Update CVS KGDB's serial driver
Message-ID: <20040226144312.GR1052@smtp.west.cox.net>
References: <20040225213626.GF1052@smtp.west.cox.net> <200402261355.18964.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402261355.18964.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 01:55:18PM +0530, Amit S. Kale wrote:
> On Thursday 26 Feb 2004 3:06 am, Tom Rini wrote:
> > The following updates the serial driver with the fixes / cleanups that
> > are in George's version of the driver.  There's a few slightly 'odd'
> > things in this patch, which stem from the fact that in my next round of
> > patches there will (a) be kernel/Kconfig.kgdb and (b) 1 kgdb i/o driver
> > at a time.
> 
> Please send them in consecutive emails. Having separate patches is fine.
> I can't figure out from this patch how a user is going to configure kgdb 8250 
> options from menuconfig.

I'll do the config bits one today.  But 'hex' is a valid word in
menuconfig :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
