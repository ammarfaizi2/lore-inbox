Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130653AbQLKUze>; Mon, 11 Dec 2000 15:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130671AbQLKUzY>; Mon, 11 Dec 2000 15:55:24 -0500
Received: from law-f58.hotmail.com ([209.185.131.121]:7685 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S130653AbQLKUzO>;
	Mon, 11 Dec 2000 15:55:14 -0500
X-Originating-IP: [66.8.160.33]
From: "Ray Strode" <halfline@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: hard lockups
Date: Mon, 11 Dec 2000 10:24:40 -1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW-F58budzxxfYXFrw000072af@hotmail.com>
X-OriginalArrivalTime: 11 Dec 2000 20:24:41.0271 (UTC) FILETIME=[64312470:01C063B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a PC164 Alpha (500Mhz) and I get hard lock ups randomly when 
accessing the internet.  It happens very frequently (like within a few 
minutes) with 2.4 kernels, but happens much more infrequently with 2.2 
kernels.  Also, I have to compile the kernel for generic alpha (NOT PC164) 
otherwise I get ide-probe errors on bootup.  My network card
is a 3com boomerang (I think? it uses 3c59x.o and it's PCI). Any ideas?

--Ray Strode
_____________________________________________________________________________________
Get more from the Web.  FREE MSN Explorer download : http://explorer.msn.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
