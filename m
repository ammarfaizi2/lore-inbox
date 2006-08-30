Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWH3Ucq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWH3Ucq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 16:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWH3Ucq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 16:32:46 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:27552 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751468AbWH3Ucp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 16:32:45 -0400
From: Foli Ayivoh <it21@arcor.de>
Reply-To: Foli Ayivoh <101551.753@compuserve.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
Date: Wed, 30 Aug 2006 22:32:42 +0200
User-Agent: KMail/1.9.4
Cc: Matt Porter <mporter@embeddedalley.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
References: <20060830062338.GA10285@kroah.com> <20060830143410.GB19477@gate.crashing.org> <20060830175529.GB6258@kroah.com>
In-Reply-To: <20060830175529.GB6258@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608302232.43125.it21@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, Aug 30, 2006 at 09:34:10AM -0500, Matt Porter wrote:
> > On Tue, Aug 29, 2006 at 11:23:38PM -0700, Greg KH wrote:
> > > A while ago, Thomas and I were sitting in the back of a conference
.
.
.
> more generic than that.
> 
> "USD" is a bit too close to "USB" for a name.  Any other ideas?
what about  U_IO     ;-)
> 
> > > Thomas has also promised to come up with some userspace code that uses
> > > this interface to show how to use it, but seems to have forgotten.
> > > Consider this a reminder :)
> > 
> > That would be nice to see. I can't see how devices and drivers
> > are registered from user space with what's here. I see
> > iio_register_device() exported but no clue how userspace tells
> > the kernel to claim a device or register an iio driver.
> 
> His posted example should show you how this all works together.
> 
> thanks,
> 
> greg k-h
>
