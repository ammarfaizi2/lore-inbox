Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbTEAX5B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 19:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbTEAX5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 19:57:00 -0400
Received: from granite.he.net ([216.218.226.66]:29458 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262810AbTEAX47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 19:56:59 -0400
Date: Thu, 1 May 2003 17:11:25 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Muizelaar <kernel@infidigm.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: request_firmware() hotplug interface.
Message-ID: <20030502001125.GA4886@kroah.com>
References: <20030501194702.GA2997@ranty.ddts.net> <20030501201943.GA3498@kroah.com> <3EB1AE73.8070408@infidigm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB1AE73.8070408@infidigm.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 07:32:03PM -0400, Jeff Muizelaar wrote:
> Greg KH wrote:
> 
> >As all devices in the kernel should now be in sysfs (if not, please let
> >me know what busses haven't been converted yet), 
> >
> How about plain old isa?

ISA PnP is converted, I don't think plain isa is.  I think a lack of
hardware and usage is probably keeping this one from being converted.

thanks,

greg k-h
