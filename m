Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbUAaAoc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 19:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264510AbUAaAoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 19:44:32 -0500
Received: from mail.kroah.org ([65.200.24.183]:43975 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264493AbUAaAoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 19:44:30 -0500
Date: Fri, 30 Jan 2004 16:44:31 -0800
From: Greg KH <greg@kroah.com>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: khubd crash on scanner disconnect
Message-ID: <20040131004431.GB10860@kroah.com>
References: <20040130173656.GA4570@merlin.emma.line.org> <20040130191453.GA7173@kroah.com> <401AB157.1040209@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401AB157.1040209@gmx.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 08:32:39PM +0100, Prakash K. Cheemplavam wrote:
> Greg KH wrote:
> >On Fri, Jan 30, 2004 at 06:36:56PM +0100, Matthias Andree wrote:
> >
> >>Hi,
> >>
> >>I have just caught this khubd NULL dereference simply by unplugging my
> >>scanner. Kernel is a current 2.6.2-rc2 from BK, PNP enabled:
> >
> >
> >Known bug, don't use that module, it's OBSOLETED.  Use xscane and libusb
> >instead.
> 
> Are you sure, it is "xscane" and not "xsane"? I thought you just did a 
> typo in my post, but now you did it twice, so no typo?

Sorry, I don't know what the program is called, as I've never used it...

greg k-h
