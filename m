Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263103AbVCXQCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbVCXQCr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 11:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbVCXQCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 11:02:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:44773 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263103AbVCXQCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 11:02:35 -0500
Date: Thu, 24 Mar 2005 08:02:25 -0800
From: Greg KH <gregkh@suse.de>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: USB problems 2.6.10
Message-ID: <20050324160225.GA19355@kroah.com>
References: <20050324130045.GA30623@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050324130045.GA30623@animx.eu.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 08:00:46AM -0500, Wakko Warner wrote:
> Please keep me CCd.
> 
> I have a system that I just updated to 2.6 and USB fails to work after some
> time (~6-8 hours) giving me the "irq 11:nobody cared" message.
> 
> This system is a supermicro p3tdde (via chipset)
> I have ACPI and Preempt enabled (which I will disable and try again)
> 
> I notice this rather quickly as my keyboard/mouse are on this controller.  I
> have an NEC chip USB2.0 card installed which is currently working.

Can you try 2.6.11 and see if that is better?

thanks,

greg k-h
