Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWDUXGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWDUXGw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 19:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWDUXGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 19:06:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62934 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750739AbWDUXGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 19:06:51 -0400
Date: Fri, 21 Apr 2006 16:09:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.16.9, amd64, usbcore: NULL pointer dereference
Message-Id: <20060421160916.37b9c771.akpm@osdl.org>
In-Reply-To: <4448FCC7.6070309@t-online.de>
References: <4448FCC7.6070309@t-online.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Added linux-usb-devel)

Harald Dunkel <harald.dunkel@t-online.de> wrote:
>
> Hi folks,
> 
> Sometimes my PC dies at boot time:
> 
> :
> usb 3-3: config 1 has 0 interfaces, different from the descriptor's value: 1
> Unable to handle kernel NULL pointer dereference at 000000000000000d RIP:
> <ffffffff8809493e>(:usbcore:usb_new_device+350)
> :
> :
> 
> Unfortunately it is not visible in any log file, so I took
> a snapshot of the screen.
> 
> Surely it would be unacceptable to send huge attachments
> to everybody on this list. Is somebody interested? Or is
> there some upload area available, that I could use?

Please email the image to myself and I'll upload it.

> # lsusb
> Bus 003 Device 003: ID 07cc:0301 Carry Computer Eng., Co., Ltd 6-in-1 Card Reader
> Bus 003 Device 002: ID 0ace:1211 ZyDAS 802.11b/g USB2 WiFi
> Bus 003 Device 004: ID 124a:4023 AirVast
> Bus 003 Device 001: ID 0000:0000
> Bus 002 Device 001: ID 0000:0000
> Bus 001 Device 001: ID 0000:0000
> 

Thanks.
