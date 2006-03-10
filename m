Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751784AbWCJQRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbWCJQRX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 11:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWCJQRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 11:17:22 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:40365
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751784AbWCJQRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 11:17:22 -0500
Date: Fri, 10 Mar 2006 08:17:06 -0800
From: Greg KH <greg@kroah.com>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Problems ejecting 4th-generation iPod with 2.6.15
Message-ID: <20060310161706.GA10772@kroah.com>
References: <dure7s$1ic$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dure7s$1ic$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 12:43:19AM -0800, Joshua Kwan wrote:
> Hi,
> 
> When I plug my iPod in via USB, and later eject it, I more often than
> not get this:
> 
> usb 5-5: reset high speed USB device using ehci_hcd and address 20
> usb 5-5: reset high speed USB device using ehci_hcd and address 20
> usb 5-5: reset high speed USB device using ehci_hcd and address 20
> usb 5-5: reset high speed USB device using ehci_hcd and address 20
> usb 5-5: reset high speed USB device using ehci_hcd and address 20
> sd 14:0:0:0: scsi: Device offlined - not ready after error recovery
> usb 5-5: USB disconnect, address 20
> 
> What's going on here?

Can you try 2.6.16-rc5 and let us know if that works better for you
here?

thanks,

greg k-h
