Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTEITOr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 15:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263422AbTEITOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 15:14:47 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:40637 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263418AbTEITOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 15:14:46 -0400
Date: Fri, 9 May 2003 12:29:08 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [Bluetooth] HCI USB driver update.   Support for SCO over HCI USB.
Message-ID: <20030509192908.GA2233@kroah.com>
References: <200304290317.h3T3HOdA027579@hera.kernel.org> <200304290317.h3T3HOdA027579@hera.kernel.org> <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com> <5.1.0.14.2.20030429145523.10c52e50@unixmail.qualcomm.com> <5.1.0.14.2.20030508123858.01c004f8@unixmail.qualcomm.com> <3EBBFC33.7050702@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBBFC33.7050702@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 12:06:27PM -0700, David Brownell wrote:
> 
> I'd certainly like the list_head.  Patch attached,
> in case Greg agrees enough.

I agree, but will only take the patch if a driver is modified to
actually use this.  I'll take both patches at once :)

thanks,

greg k-h
