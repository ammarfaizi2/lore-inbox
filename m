Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWDSPs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWDSPs4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 11:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWDSPs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 11:48:56 -0400
Received: from smtp6.libero.it ([193.70.192.59]:19612 "EHLO smtp6.libero.it")
	by vger.kernel.org with ESMTP id S1750937AbWDSPsz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 11:48:55 -0400
Date: Wed, 19 Apr 2006 17:48:28 +0200
Message-Id: <IXZ7WS$7C97ED4495AB8E41BB97FB4821D58030@libero.it>
Subject: Re: Problems ejecting 4th-generation iPod with 2.6.15
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
From: "androi\@inwind\.it" <androi@inwind.it>
To: "greg" <greg@kroah.com>
Cc: "joshk" <joshk@triplehelix.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-usb-devel" <linux-usb-devel@lists.sourceforge.net>
X-XaM3-API-Version: 4.3 (R1) (B3pl15)
X-SenderIP: 217.220.29.248
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Initial Header -----------

>From      : linux-kernel-owner@vger.kernel.org
To          : "Joshua Kwan" joshk@triplehelix.org
Cc          : linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Date      : Fri, 10 Mar 2006 08:17:06 -0800
Subject : Re: Problems ejecting 4th-generation iPod with 2.6.15







> On Fri, Mar 10, 2006 at 12:43:19AM -0800, Joshua Kwan wrote:
> > Hi,
> > 
> > When I plug my iPod in via USB, and later eject it, I more often than
> > not get this:
> > 
> > usb 5-5: reset high speed USB device using ehci_hcd and address 20
> > usb 5-5: reset high speed USB device using ehci_hcd and address 20
> > usb 5-5: reset high speed USB device using ehci_hcd and address 20
> > usb 5-5: reset high speed USB device using ehci_hcd and address 20
> > usb 5-5: reset high speed USB device using ehci_hcd and address 20
> > sd 14:0:0:0: scsi: Device offlined - not ready after error recovery
> > usb 5-5: USB disconnect, address 20
> > 
> > What's going on here?
> 
> Can you try 2.6.16-rc5 and let us know if that works better for you
> here?
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
> 
> 


I've the same problem, I also tried with kernel 2.6.17.rc1 but nothing :(.

Any helps will be very appreciate.

Thanks in advance

