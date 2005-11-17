Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbVKQVth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbVKQVth (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbVKQVth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:49:37 -0500
Received: from 8.ctyme.com ([69.50.231.8]:46495 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1751501AbVKQVth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:49:37 -0500
Message-ID: <437CFAF0.30500@perkel.com>
Date: Thu, 17 Nov 2005 13:49:36 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.14.2 Kernel Panic - Athlon X2 SATA NVidia Chipset
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was attempting to do some upgrades last night and run into a bug again 
that I thought had been fixed but apparently hasn't. The kernel crashed 
and I got the same gargage in the screen about the sata_nv drivers. 
(Sorry I can't be more specific but it want a screen full of SATA 
relared errors and panic).

The current computer that was running is an Asus A8V Deluxe MB. Had IDE 
drives and doing great. When I tried switching to SATA drives it ran for 
about an hour and then crashed as stated above. Put the old IDE drive 
back in and doing fine again. Unlike before when I thought it was 
related to having 4 gigs of ram - this machine only had 3 gigs.

Additionally, tried to switch computers to a new machine I just built. 
The new computer has a Gigabyte GA-K8N51GMF-9 Motherboard. Again it's 
nVidia. Has 2 SATA drives in it and was working fine with a single core 
processor. I switched CPUs and put the dual core in and within minutes I 
got the same SATA related crash.

Whatever the problem is with nVidia and SATA and Athlon X2 processors - 
it is still not fixed. Anyone else seeing this? I'm not a programmer. 
What can I do to help?

-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com

