Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265643AbUBFVFo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 16:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265621AbUBFVFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 16:05:44 -0500
Received: from mail.kroah.org ([65.200.24.183]:49389 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265643AbUBFVFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 16:05:43 -0500
Date: Fri, 6 Feb 2004 13:04:26 -0800
From: Greg KH <greg@kroah.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: gene.heskett@verizon.net, Azog <slashmail@arnor.net>,
       Adrian Bunk <bunk@fs.tum.de>, Tom Rini <trini@kernel.crashing.org>,
       Andre Noll <noll@mathematik.tu-darmstadt.de>,
       Linux-Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] remove USB_SCANNER
Message-ID: <20040206210426.GA1803@kroah.com>
References: <20040126215036.GA6906@kroah.com> <20040205011423.GA6092@kroah.com> <1076001658.3225.101.camel@moria.arnor.net> <200402052015.22926.gene.heskett@verizon.net> <4024001D.80308@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4024001D.80308@tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 03:59:09PM -0500, Bill Davidsen wrote:
> I think the problem is not that it doesn't work with kernel, but it 
> doesn't work with the application. And while some people may be able to 
> ignore having a system which will work with both 2.4 and 2.6 kernels, 
> for many systems it may not be practical to change config to something 
> which will not work in 2.4 in hopes it might work in 2.6.

The libusb solution for scanner devices works just fine with 2.4 also.

thanks,

greg k-h
