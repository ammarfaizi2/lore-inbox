Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVFCTdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVFCTdi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 15:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVFCTbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 15:31:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:53703 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261514AbVFCTa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 15:30:27 -0400
Date: Fri, 3 Jun 2005 12:30:14 -0700
From: Greg KH <greg@kroah.com>
To: Dag Nygren <dag@newtech.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OHCI driver have problems with USB 2.0 memory devices
Message-ID: <20050603193014.GB7435@kroah.com>
References: <20050603181454.GA5722@kroah.com> <20050603191627.20230.qmail@dag.newtech.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050603191627.20230.qmail@dag.newtech.fi>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 10:16:27PM +0300, Dag Nygren wrote:
> > On Fri, Jun 03, 2005 at 08:27:01PM +0300, Dag Nygren wrote:
> > > 
> > > Hi,
> > > 
> > > just installed 2.6.11.11 on a single board computer using
> > > a SGS Thomson integrated USB controller and found that
> > > inserting a USB 2.0 stick generated a "IRQ INTR_SF lossage"
> > > message and further lockup of the driver. Ie. a cat of 
> > > /proc/bus/usb/devices will freeze the cat process.
> > 
> > Does 2.6.12-rc5 have this same problem?
> 
> Haven't tried, if you think it will make a difference
> I can do a test on Monday when back at work.

Yes, please do.

thanks,

greg k-h
