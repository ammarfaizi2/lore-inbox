Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265179AbTLZN73 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 08:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbTLZN72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 08:59:28 -0500
Received: from bay13-f29.bay13.hotmail.com ([64.4.31.29]:51716 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S265179AbTLZN71
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 08:59:27 -0500
X-Originating-IP: [195.178.133.42]
X-Originating-Email: [gelstat_mystery@hotmail.com]
From: "dick morales" <gelstat_mystery@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: <xmas crazyness>
Date: Fri, 26 Dec 2003 05:59:26 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY13-F298GVaVJVKqV0003d319@hotmail.com>
X-OriginalArrivalTime: 26 Dec 2003 13:59:27.0039 (UTC) FILETIME=[798FBCF0:01C3CBB8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've recently invent cute idea - put a configure file in linux/ tree, so 
users
can do things like that:

#cd /usr/src/linux
#./configure
#make -j5
#make install
#reboot

&have completely new well-cfgured kernel.

maybe this needs some nifty .pl or .c converter of /proc/config.gz
to new .config in linux/scripts/. I htink its highly need to be included, 
bcause it helps poor users migrate to 2.6 from earlier 2.5 or 2.4 or even 
2.2/2.0 ;).
Compare this with abs stupid /proc/updike ;)!
By the way, what happens with developers? why they hang at 2.6.0? we want 
-bk<N> patches !


Please cc/bc me, I am not in list.

_________________________________________________________________
MSN 8 with e-mail virus protection service: 2 months FREE* 
http://join.msn.com/?page=features/virus

