Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbTEIAJd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 20:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbTEIAJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 20:09:33 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:1702 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262189AbTEIAJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 20:09:32 -0400
Date: Thu, 8 May 2003 17:22:41 -0700
From: Greg KH <greg@kroah.com>
To: David van Hoose <davidvh@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI conflict with USB
Message-ID: <20030509002240.GA4328@kroah.com>
References: <3EBADF3C.1040609@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBADF3C.1040609@cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 05:50:36PM -0500, David van Hoose wrote:
> I'm wondering if there is any work towards correcting the ACPI conflict 
> with USB. On my system, I cannot use any USB devices due to a timeout 
> anytime I use ACPI with my kernel. Other people have noticed this 
> happening on their systems as well, so I am assuming it isn't just on my 
> system.

Have you tried the latest 2.5 kernels?  I think this is fixed in 2.5.69
for the majority of people.  Also, does booting with "noapic" work for
you?

thanks,

greg k-h
