Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265715AbUA0U34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265752AbUA0U34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:29:56 -0500
Received: from mail.kroah.org ([65.200.24.183]:31457 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265715AbUA0U3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:29:55 -0500
Date: Tue, 27 Jan 2004 12:28:10 -0800
From: Greg KH <greg@kroah.com>
To: Roman Zippel <zippel@linux-m68k.org>, Linus Torvalds <torvalds@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: PATCH: (as177)  Add class_device_unregister_wait() and platform_device_unregister_wait() to the driver model core
Message-ID: <20040127202810.GD27240@kroah.com>
References: <Pine.LNX.4.44L0.0401251224530.947-100000@ida.rowland.org> <Pine.LNX.4.58.0401251054340.18932@home.osdl.org> <Pine.LNX.4.58.0401261435160.7855@serv> <20040127193227.A30224@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040127193227.A30224@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 07:32:28PM +0000, Russell King wrote:
> 
> (and yes, pci_module_init() is buggy as it currently stands, and I
> believe GregKH has a patch in his queue from the stability freeze
> from yours truely to fix it.)

Yes I still have it, I need to dig that out and send it onward...  Sorry
about the delay.

greg k-h
