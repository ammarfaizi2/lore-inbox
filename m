Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbTELQzM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 12:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbTELQzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 12:55:12 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:28936 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S262206AbTELQzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 12:55:11 -0400
Subject: Re: PCI problem [was Re: ACPI conflict with USB]
From: Stian Jordet <liste@jordet.nu>
To: Greg KH <greg@kroah.com>
Cc: David van Hoose <davidvh@cox.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20030512163003.GA27980@kroah.com>
References: <3EBADF3C.1040609@cox.net> <20030509002240.GA4328@kroah.com>
	 <1052444521.3ebb076946267@webmail.jordet.nu> <3EBB0A95.20902@cox.net>
	 <3EBD49CF.7030304@cox.net>  <20030512163003.GA27980@kroah.com>
Content-Type: text/plain
Message-Id: <1052759280.1842.9.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 12 May 2003 19:08:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man, 12.05.2003 kl. 18.30 skrev Greg KH:
> On Sat, May 10, 2003 at 01:49:51PM -0500, David van Hoose wrote:
> > 
> > If I boot with pci=noacpi, I do *not* have the problem.
> 
> Yeah!  Then I would recommend using this option for your hardware, and
> ignoring the error messages at startup.  The "nobody cared!" messages
> are being worked on by others, and are probably not because of this
> problem at all (lots of people see them right now on lots of different
> hardware configurations.)

My box doesn't boot with pci=noacpi, so that doesn't really help my
problem much :)

Best regards,
Stian

