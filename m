Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbUBKIYb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 03:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUBKIYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 03:24:30 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:2688 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S263637AbUBKIY3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 03:24:29 -0500
Date: Wed, 11 Feb 2004 09:24:27 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ping Cheng <pingc@wacom.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Greg KH '" <greg@kroah.com>
Subject: Re: Wacom USB driver patch
Message-ID: <20040211082427.GA247@ucw.cz>
References: <28E6D16EC4CCD71196610060CF213AEB065BBF@wacom-nt2.wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28E6D16EC4CCD71196610060CF213AEB065BBF@wacom-nt2.wacom.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 05:23:11PM -0800, Ping Cheng wrote:

>  <<linuxwacom.patch>> 
> Attached is a wacom driver patch for kernel 2.6. I have sent my patch to
> Vojtech last year. But, he didn't commit it. I bet he's busy. So, hope
> someone in this list can help me check the code in.
> 
> Please reply to me directly since I am not in linux-kernel mailing list. 

I'll take a look at it.

> Thanks!
> 
> Ping
> 
> -----Original Message-----
> From: Greg KH
> To: Ping Cheng
> Sent: 2/10/04 4:54 PM
> Subject: Re: Wacom USB driver patch
> 
> On Tue, Feb 10, 2004 at 04:48:32PM -0800, Ping Cheng wrote:
> > Can someone in the To list commit my patch? The patch is based on
> wacom.c
> > 1.32 and hid-core.c 1.72 at http://linux.bkbits.net:8080/linux-2.5. 
> 
> So this is for the 2.6 kernel?
> 
> Your patch is line-wrapped, and can't be applied by using 'patch -p1'
> from the main kernel directory.
> 
> Vojtech would be the one to ACK this patch or not, but you also might
> want to CC: the linux-usb-devel mailing list.
> 
> thanks,
> 
> greg k-h



-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
