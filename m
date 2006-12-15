Return-Path: <linux-kernel-owner+w=401wt.eu-S1753085AbWLORyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbWLORyI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 12:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753088AbWLORyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 12:54:08 -0500
Received: from cantor2.suse.de ([195.135.220.15]:52163 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087AbWLORyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 12:54:07 -0500
Date: Fri, 15 Dec 2006 09:53:44 -0800
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18.5 usb/sysfs bug.
Message-ID: <20061215175344.GA15871@kroah.com>
References: <20061215175027.GA17987@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215175027.GA17987@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2006 at 12:50:27PM -0500, Dave Jones wrote:
> Happens during every boot, though bootup continues afterwards.

Can you enable CONFIG_USB_DEBUG and send the log info that happens right
before this oops?

> I'll give .20rc1 a shot real soon.

2.6.19 would be interesting to try too.  I'll be worried if it's not
fixed there.

thanks,

greg k-h
