Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbUEOMVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUEOMVF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 08:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbUEOMU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 08:20:56 -0400
Received: from bay18-f105.bay18.hotmail.com ([65.54.187.155]:60943 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262382AbUEOMUy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 08:20:54 -0400
X-Originating-IP: [67.22.169.229]
X-Originating-Email: [jpiszcz@hotmail.com]
From: "Justin Piszcz" <jpiszcz@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: apiszcz@solarrain.com
Subject: RE: Linux Kernel 2.6.6 IDE shutdown problems.
Date: Sat, 15 May 2004 12:20:53 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY18-F105X7rz6AvEm0002622f@hotmail.com>
X-OriginalArrivalTime: 15 May 2004 12:20:53.0712 (UTC) FILETIME=[11306500:01C43A77]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is the 2.6.6 kernel muxed my drive and when it fscked upon 
reboot it deleted /etc/mtab and lilo.conf!

Luckily I restored them from a backup and now run 2.6.5 and it is working 
fine.

Linux 2.6.6 is a nightmare.

I am looking into the benchmark problem with 2.6.6 now.


--- In linux-kernel@yahoogroups.com, "Justin Piszcz" <jpiszcz@h...> wrote:
>Now whenever I reboot it says input/output errors when it tries to mount 
>the drive? I will look into this further.
>
>_________________________________________________________________
>Stop worrying about overloading your inbox - get MSN Hotmail Extra Storage! 
>http://join.msn.click-url.com/go/onm00200362ave/direct/01/
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@v...
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org

_________________________________________________________________
Check out the coupons and bargains on MSN Offers! http://youroffers.msn.com

