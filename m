Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVFCSPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVFCSPW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 14:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVFCSPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 14:15:22 -0400
Received: from mail.kroah.org ([69.55.234.183]:4527 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261477AbVFCSPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 14:15:05 -0400
Date: Fri, 3 Jun 2005 11:14:54 -0700
From: Greg KH <greg@kroah.com>
To: Dag Nygren <dag@newtech.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OHCI driver have problems with USB 2.0 memory devices
Message-ID: <20050603181454.GA5722@kroah.com>
References: <20050603172701.29736.qmail@dag.newtech.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050603172701.29736.qmail@dag.newtech.fi>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 08:27:01PM +0300, Dag Nygren wrote:
> 
> Hi,
> 
> just installed 2.6.11.11 on a single board computer using
> a SGS Thomson integrated USB controller and found that
> inserting a USB 2.0 stick generated a "IRQ INTR_SF lossage"
> message and further lockup of the driver. Ie. a cat of 
> /proc/bus/usb/devices will freeze the cat process.

Does 2.6.12-rc5 have this same problem?

thanks,

greg k-h
