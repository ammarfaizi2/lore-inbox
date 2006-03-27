Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWC0Uxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWC0Uxt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 15:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWC0Uxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 15:53:49 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:49868 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750971AbWC0Uxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 15:53:48 -0500
Subject: AGP graphics card in "PCI mode"?
From: Florin Andrei <florin@andrei.myip.org>
Reply-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 27 Mar 2006 12:53:43 -0800
Message-Id: <1143492823.2289.10.camel@rivendell.home.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using:
- motherboard ECS L7S7A2

http://www.ecs.com.tw/ECSWeb/Downloads/ProductsDetail_Download.aspx?categoryid=1&typeid=4&detailid=267&DetailName=Driver&DetailDesc=L7S7A2(1.1A)&MenuID=45&LanID=0
http://www.mainboard.cz/mb/ecs/L7S7A2.htm

- AGP graphics card GeForce FX 5200 Ultra
- Linux Fedora Core 5
- kernel 2.6.15-1.2054_FC5

I installed Second Life ( http://secondlife.com/ ) on this system, both
the Windows and the Linux versions. Both versions claimed that my video
card is either PCI or "AGP running in PCI mode" and, if the latter was
true, I needed to install some drivers.

On Windows, I installed the AGP driver from here:

http://www.ecs.com.tw/ECSWeb/Downloads/ProductsDetail_Download.aspx?categoryid=1&typeid=4&detailid=267&DetailName=Driver&DetailDesc=L7S7A2(1.1A)&MenuID=45&LanID=0

After that, Second Life did not complain about the graphics card
anymore.

However, after installing that driver on Windows, the speed of all 3D
applications (mostly games) on my Windows partition increased
tremendously. All 3D games now have a much higher FPS and everything
moves smoothly.

Is there anything I can do on Linux to get this speed increase? Is there
any driver under Linux that's similar to the one I installed on Windows?
I thought that all AGP buses are supported on Linux by default.

And what is the deal with an AGP card running in "PCI mode" anyway? What
does "PCI mode" mean in this case? I thought an AGP card is an AGP
card. :-)

-- 
Florin Andrei

http://florin.myip.org/

