Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTEIB3h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 21:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTEIB3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 21:29:37 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:10248 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S262174AbTEIB3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 21:29:36 -0400
Message-ID: <1052444521.3ebb076946267@webmail.jordet.nu>
Date: Fri,  9 May 2003 03:42:01 +0200
From: Stian Jordet <liste@jordet.nu>
To: Greg KH <greg@kroah.com>
Cc: David van Hoose <davidvh@cox.net>, linux-kernel@vger.kernel.org
Subject: Re: ACPI conflict with USB
References: <3EBADF3C.1040609@cox.net> <20030509002240.GA4328@kroah.com>
In-Reply-To: <20030509002240.GA4328@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 192.168.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sitat Greg KH <greg@kroah.com>:

> On Thu, May 08, 2003 at 05:50:36PM -0500, David van Hoose wrote:
> > I'm wondering if there is any work towards correcting the ACPI conflict 
> > with USB. On my system, I cannot use any USB devices due to a timeout 
> > anytime I use ACPI with my kernel. Other people have noticed this 
> > happening on their systems as well, so I am assuming it isn't just on my 
> > system.
> 
> Have you tried the latest 2.5 kernels?  I think this is fixed in 2.5.69
> for the majority of people.  Also, does booting with "noapic" work for
> you?

If it is supposed to have been fixed in 2.5.69, that must be the reason usb
stopped working with acpi on 2.5.69 for me. Worked fine with 2.5.68.

http://marc.theaimsgroup.com/?l=linux-kernel&m=105216850332081&w=2

Only three days since I reported it, and you say it is fixed? Gee.

David: The consensus on acpi-devel is to report it in bugzilla, and see what
happens.

Best regards,
Stian
