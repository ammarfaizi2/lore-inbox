Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266476AbUBGAOU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 19:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266567AbUBGAOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 19:14:20 -0500
Received: from mail.kroah.org ([65.200.24.183]:6600 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266476AbUBGAON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 19:14:13 -0500
Date: Fri, 6 Feb 2004 16:14:10 -0800
From: Greg KH <greg@kroah.com>
To: Steve Kieu <haiquy@yahoo.com>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Need help about scanner (2.6.2-mm1)
Message-ID: <20040207001410.GA4492@kroah.com>
References: <20040206235749.19346.qmail@web10408.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206235749.19346.qmail@web10408.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 10:57:49AM +1100, Steve Kieu wrote:
> Hi,
> 
> I noticed that 2.6.2-mm1, usb scanner is removed. With
> vanilla 2.6.2, this modules always OOP and somebody
> said we should use libusb instead. However after
> googling for a while I can not find any documentation
> how to use that even in the libusb homepage. Please
> help me , or pinpoint some place I could have some
> guides. Thank
> you.


Get the latest version of xsane and use it.  It should have the libusb
support built into it already.

If you have any problems, try asking on the xsane mailing lists.

Good luck,

greg k-h
