Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVBVNMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVBVNMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 08:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVBVNMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 08:12:24 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:51353 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S262290AbVBVNMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 08:12:20 -0500
Date: Tue, 22 Feb 2005 08:12:19 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: OT: Why is usb data many times the cpu hog that firewire is?
In-reply-to: <20050222085326.GD7524@ip68-4-98-123.oc.oc.cox.net>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200502220812.19664.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200502211216.35194.gene.heskett@verizon.net>
 <20050222085326.GD7524@ip68-4-98-123.oc.oc.cox.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 February 2005 03:53, Barry K. Nathan wrote:

>Is your USB 1.1 controller UHCI or OHCI? If it's UHCI, perhaps you
> could try an OHCI controller (e.g. some USB PCI cards) and see if
> that makes any difference. (I remember reading something about OHCI
> being more efficient than UHCI in some cases, although I don't
> remember the details now.)

I'm already useing the OHCI version, its an nforce2 chipset.

And I think the lack of 'efficiency' is the jpg decodeing.  That just 
means I can't run the capture full time, only when its triggered.  
Thats doable...

>-Barry K. Nathan <barryn@pobox.com>

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
