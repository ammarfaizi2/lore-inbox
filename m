Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVFCTQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVFCTQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 15:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVFCTQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 15:16:29 -0400
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:19106
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP id S261284AbVFCTQ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 15:16:28 -0400
Message-ID: <20050603191627.20230.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-0.27
To: Greg KH <greg@kroah.com>
cc: Dag Nygren <dag@newtech.fi>, linux-kernel@vger.kernel.org, dag@newtech.fi
Subject: Re: OHCI driver have problems with USB 2.0 memory devices 
In-Reply-To: Message from Greg KH <greg@kroah.com> 
   of "Fri, 03 Jun 2005 11:14:54 PDT." <20050603181454.GA5722@kroah.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Jun 2005 22:16:27 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jun 03, 2005 at 08:27:01PM +0300, Dag Nygren wrote:
> > 
> > Hi,
> > 
> > just installed 2.6.11.11 on a single board computer using
> > a SGS Thomson integrated USB controller and found that
> > inserting a USB 2.0 stick generated a "IRQ INTR_SF lossage"
> > message and further lockup of the driver. Ie. a cat of 
> > /proc/bus/usb/devices will freeze the cat process.
> 
> Does 2.6.12-rc5 have this same problem?

Haven't tried, if you think it will make a difference
I can do a test on Monday when back at work.

Cheers
Dag


