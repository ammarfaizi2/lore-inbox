Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTELSDI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTELSCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:02:32 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:40917 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262447AbTELRtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:49:12 -0400
Date: Mon, 12 May 2003 11:01:46 -0700
From: Greg KH <greg@kroah.com>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: David Brownell <david-b@pacbell.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [Bluetooth] HCI USB driver update. Support for SCO over HCI USB.
Message-ID: <20030512180146.GB28675@kroah.com>
References: <200304290317.h3T3HOdA027579@hera.kernel.org> <200304290317.h3T3HOdA027579@hera.kernel.org> <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com> <5.1.0.14.2.20030429145523.10c52e50@unixmail.qualcomm.com> <5.1.0.14.2.20030508123858.01c004f8@unixmail.qualcomm.com> <3EBBFC33.7050702@pacbell.net> <1052517124.10458.199.camel@localhost.localdomain> <20030509230542.GA3267@kroah.com> <5.1.0.14.2.20030512105155.0d1773c0@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030512105155.0d1773c0@unixmail.qualcomm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 10:53:48AM -0700, Max Krasnyansky wrote:
> 
> So, I guess in general you're ok with adding ->drv_cb and ->hcd_cb to 'struct urb' ?

I am, as long as someone uses it :)

thanks,

greg k-h
