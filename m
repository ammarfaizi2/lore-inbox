Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTEDJZi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 05:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbTEDJZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 05:25:37 -0400
Received: from WebDev.iNES.RO ([80.86.100.174]:36481 "EHLO webdev.ines.ro")
	by vger.kernel.org with ESMTP id S263574AbTEDJZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 05:25:37 -0400
Date: Sun, 4 May 2003 12:38:04 +0300 (EEST)
From: Andrei Ivanov <andrei.ivanov@ines.ro>
X-X-Sender: shadow@webdev.ines.ro
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: usb [mouse] not working in mm4
In-Reply-To: <20030503193135.GA17970@kroah.com>
Message-ID: <Pine.LNX.4.50L0.0305041235580.4098-100000@webdev.ines.ro>
References: <Pine.LNX.4.50L0.0305031550330.4098-200000@webdev.ines.ro>
 <20030503193135.GA17970@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



No, on bk11 it does the same thing.


On Sat, 3 May 2003, Greg KH wrote:

> On Sat, May 03, 2003 at 03:55:12PM +0300, Andrei Ivanov wrote:
> > usb 1-2: USB device not accepting new address=2 (error=-110)
> > hub 1-0:0: new USB device on port 2, assigned address 3
> > usb 1-2: USB device not accepting new address=3 (error=-110)
> 
> Hm, interrupts aren't getting to the usb host controller.  Does this
> work ok on the latest -bk tree for you?
> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
