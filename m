Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWDVAtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWDVAtY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 20:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWDVAtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 20:49:24 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:5428 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750799AbWDVAtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 20:49:23 -0400
Date: Fri, 21 Apr 2006 18:49:07 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.16.9, amd64, usbcore: NULL pointer dereference
In-reply-to: <6463t-5rY-11@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Harald Dunkel <harald.dunkel@t-online.de>
Message-id: <44497D83.2050702@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6463t-5rY-11@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:
> Hi folks,
> 
> Sometimes my PC dies at boot time:
> 
> :
> usb 3-3: config 1 has 0 interfaces, different from the descriptor's value: 1
> Unable to handle kernel NULL pointer dereference at 000000000000000d RIP:
> <ffffffff8809493e>(:usbcore:usb_new_device+350)

Sounds similar to this?

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=186660

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

