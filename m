Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbTELQPj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 12:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTELQPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 12:15:39 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:65245 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262246AbTELQPj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 12:15:39 -0400
Date: Mon, 12 May 2003 09:30:03 -0700
From: Greg KH <greg@kroah.com>
To: David van Hoose <davidvh@cox.net>
Cc: Stian Jordet <liste@jordet.nu>, linux-kernel@vger.kernel.org
Subject: Re: PCI problem [was Re: ACPI conflict with USB]
Message-ID: <20030512163003.GA27980@kroah.com>
References: <3EBADF3C.1040609@cox.net> <20030509002240.GA4328@kroah.com> <1052444521.3ebb076946267@webmail.jordet.nu> <3EBB0A95.20902@cox.net> <3EBD49CF.7030304@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBD49CF.7030304@cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 01:49:51PM -0500, David van Hoose wrote:
> 
> If I boot with pci=noacpi, I do *not* have the problem.

Yeah!  Then I would recommend using this option for your hardware, and
ignoring the error messages at startup.  The "nobody cared!" messages
are being worked on by others, and are probably not because of this
problem at all (lots of people see them right now on lots of different
hardware configurations.)

thanks,

greg k-h
