Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWIDLGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWIDLGX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWIDLGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:06:22 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:51360 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S932141AbWIDLGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:06:21 -0400
Date: Mon, 04 Sep 2006 07:05:53 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.18-rc6
In-reply-to: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org>
To: linux-kernel@vger.kernel.org
Message-id: <200609040705.53780.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 September 2006 22:42, Linus Torvalds wrote:
>Things are definitely calming down, and while I'm not ready to call it a
>final 2.6.18 yet, this migt be the last -rc.
>
It has one new build warning, no idea if show stopper or not:
----------
drivers/usb/input/hid-core.c:1447:1: warning: "USB_DEVICE_ID_GTCO_404" 
redefined
drivers/usb/input/hid-core.c:1446:1: warning: this is the location of the 
previous definition
----------
until after I boot to it...

And that didn't seem to effect the mouse.  Other usb stuff has not been 
exersized yet.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.

-- 
VGER BF report: U 0.623711
