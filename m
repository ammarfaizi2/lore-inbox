Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWF3Cvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWF3Cvl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 22:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWF3Cvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 22:51:41 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:59069 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751443AbWF3Cvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 22:51:40 -0400
Date: Thu, 29 Jun 2006 22:51:37 -0400
From: Andy Gay <andy@andynet.net>
Subject: Re: USB driver for Sierra Wireless EM5625/MC5720 1xEVDO modules
In-reply-to: <adabqsbfjrn.fsf@cisco.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Greg KH <gregkh@suse.de>, Jeremy Fitzhardinge <jeremy@goop.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Message-id: <1151635897.3285.394.camel@tahini.andynet.net>
MIME-version: 1.0
X-Mailer: Evolution 2.4.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1151537247.3285.278.camel@tahini.andynet.net>
	<20060630021332.GB30911@suse.de>  <adabqsbfjrn.fsf@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-29 at 19:40 -0700, Roland Dreier wrote:
>  > or:
>  >   - send a patch against 2.6.17 that is my changes + your fixes to
>  >     actually make it work.
>  > 
>  > My patch was just a "throw it out there and see what works or not", as I
>  > don't even have the device to test it with.
> 
> I would love to see such a patch.  I have a Kyocera KPC650 and I would
> love to get better performance with it under Linux...
Hmm. That's not one of the current list of devices this driver supports.
Is it a usb-serial interface like the other Airprime stuff?

> 
>  - R.

