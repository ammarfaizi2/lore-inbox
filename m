Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263511AbTEIWXU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 18:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263516AbTEIWXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 18:23:20 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:59050 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id S263511AbTEIWXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 18:23:18 -0400
Subject: Re: [linux-usb-devel] Re: [Bluetooth] HCI USB driver update.  
	Support for SCO over HCI USB.
From: Max Krasnyansky <maxk@qualcomm.com>
To: Greg KH <greg@kroah.com>
Cc: David Brownell <david-b@pacbell.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20030509192908.GA2233@kroah.com>
References: <200304290317.h3T3HOdA027579@hera.kernel.org>
	 <200304290317.h3T3HOdA027579@hera.kernel.org>
	 <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com>
	 <5.1.0.14.2.20030429145523.10c52e50@unixmail.qualcomm.com>
	 <5.1.0.14.2.20030508123858.01c004f8@unixmail.qualcomm.com>
	 <3EBBFC33.7050702@pacbell.net>  <20030509192908.GA2233@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052517274.10458.206.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 May 2003 15:35:45 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-09 at 12:29, Greg KH wrote:
> On Fri, May 09, 2003 at 12:06:27PM -0700, David Brownell wrote:
> > 
> > I'd certainly like the list_head.  Patch attached,
> > in case Greg agrees enough.
> 
> I agree, but will only take the patch if a driver is modified to
> actually use this.  I'll take both patches at once :)

Ok. Sounds good to me. 
But I also need ->drv_cb[].   

Max

