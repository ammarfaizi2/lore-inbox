Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbTD2VXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 17:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbTD2VXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 17:23:14 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:57266 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261847AbTD2VXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 17:23:10 -0400
Date: Tue, 29 Apr 2003 14:37:12 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Max Krasnyansky <maxk@qualcomm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [Bluetooth] HCI USB driver update. Support for SCO over HCI USB.
Message-ID: <20030429213712.GA8810@kroah.com>
References: <200304290317.h3T3HOdA027579@hera.kernel.org> <200304290317.h3T3HOdA027579@hera.kernel.org> <5.1.0.14.2.20030429131303.10d7f330@unixmail.qualcomm.com> <3EAEF11B.4070000@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EAEF11B.4070000@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 02:39:39PM -0700, David Brownell wrote:
> 
> > I was actually going to ask you guys if you'd be interested
> > in generalizing this _urb_queue() stuff that I have for
> > other drivers. Current URB api does not provide any interface
> > for queueing/linking/etc of URBs in the _driver_ itself.
> 
> I only saw fragments of the original patch -- could you be just
> a bit more specific?

The whole patch can be seen at:
	http://marc.theaimsgroup.com/?l=bk-commits-head&m=105158631404987


thanks,

greg k-h
