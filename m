Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267544AbUHEFEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267544AbUHEFEV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 01:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267551AbUHEFDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 01:03:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:7808 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267544AbUHEFBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 01:01:19 -0400
Date: Wed, 4 Aug 2004 21:36:37 -0700
From: Greg KH <greg@kroah.com>
To: Alex Williamson <alex.williamson@hp.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] dev_acpi: device driver for userspace access to ACPI
Message-ID: <20040805043636.GA28244@kroah.com>
References: <1091552426.4981.103.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091552426.4981.103.camel@tdi>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 11:00:26AM -0600, Alex Williamson wrote:
> 
>   Populating the sysfs tree didn't seem to generate as much interest as
> I'd hoped and I don't think it kept with the spirit of sysfs very well.

I'm sorry if I didn't speak up at the time, but I still think that your
sysfs patches were the right way to go.  Why do you think they don't
keep with the spirit of sysfs?  Do you have a pointer to your last
patch that exported the acpi table info through sysfs?

thanks,

greg k-h
