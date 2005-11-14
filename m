Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVKNT4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVKNT4p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbVKNT4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:56:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:26811 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932068AbVKNT4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:56:44 -0500
Date: Mon, 14 Nov 2005 11:43:09 -0800
From: Greg KH <greg@kroah.com>
To: Brad Campbell <brad@wasp.net.au>
Cc: George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Calibration issues with USB disc present.
Message-ID: <20051114194309.GA1945@kroah.com>
References: <43750EFD.3040106@mvista.com> <1131746228.2542.11.camel@cog.beaverton.ibm.com> <20051112050502.GC27700@kroah.com> <4376130D.1080500@mvista.com> <20051112213332.GA16016@kroah.com> <4378DDC5.80103@mvista.com> <20051114184940.GA876@kroah.com> <4378E9A8.5050807@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4378E9A8.5050807@wasp.net.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 11:46:48PM +0400, Brad Campbell wrote:
> Greg KH wrote:
> >>>completly, if possible.  And then complain loudly to the vendor to fix
> >>>their BIOS.
> >>But if one is booting from that device...
> >
> >Booting from a USB device?  I can see this happening when installing a
> >distro, and you boot from the USB cdrom, but not for "normal"
> >operations.
> >
> 
> Just as a point of reference I have a machine here that boots from a USB 
> keystick and runs from an NFS Root. It's a diskless machine that has no 
> net-boot ability. I have used this on a number of machines over recent 
> history.

Then I guess your BIOS didn't do the horrible things that the original
poster was reporting, which is good :)

thanks,

greg k-h
