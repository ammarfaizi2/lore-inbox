Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUBBXie (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 18:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUBBXic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 18:38:32 -0500
Received: from mail.kroah.org ([65.200.24.183]:61658 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262425AbUBBXi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 18:38:27 -0500
Date: Mon, 2 Feb 2004 15:32:43 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] udev 015 release
Message-ID: <20040202233243.GA1688@kroah.com>
References: <20040126215036.GA6906@kroah.com> <1075401020.7680.25.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075401020.7680.25.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 08:30:20PM +0200, Martin Schlemmer wrote:
> On Mon, 2004-01-26 at 23:50, Greg KH wrote:
> 
> I see latest version is very noisy, and although it is a good option
> to have, I think it should be tweakable (and recompiling is not always
> an option if you want some quick debugging).
> 
> Attached is a simple patch to add a config option to udev.conf to toggle
> logging.

I'm going to hold off on this patch for now for a number of reasons:
	- doesn't apply anymore
	- is buggy as your follow on message stated
	- I don't think it's really needed.

But feel free to convince me otherwise :)

thanks,

greg k-h
