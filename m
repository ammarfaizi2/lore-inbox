Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbUA3Rt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbUA3Rt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:49:56 -0500
Received: from mail.kroah.org ([65.200.24.183]:36072 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263564AbUA3Rtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:49:52 -0500
Date: Fri, 30 Jan 2004 09:49:35 -0800
From: Greg KH <greg@kroah.com>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 015 release
Message-ID: <20040130174935.GC5265@kroah.com>
References: <20040126215036.GA6906@kroah.com> <401A8A35.1020105@gmx.de> <20040130172310.GB5265@kroah.com> <401A97E0.4010704@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401A97E0.4010704@gmx.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 06:44:00PM +0100, Prakash K. Cheemplavam wrote:
> >What does:
> >	usbinfo -a -p /sys/class/usb/scanner0
> >say?
> 
> Uhm, where to get this? I don't have it and I dunno which gentoo ebuild 
> installs it. But I found a graphic app called "usbview". It basically 
> gives the same infos as lsusb. Well, nevermind, I'l try what you said 
> down. I'll try to get xsane goind with libusb.

Oops, sorry, that should have been 'udevinfo' not 'usbinfo'.

Not awake yet...

greg k-h
