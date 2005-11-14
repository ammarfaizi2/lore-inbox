Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVKNUO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVKNUO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbVKNUO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:14:26 -0500
Received: from 8.ctyme.com ([69.50.231.8]:17623 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S932082AbVKNUOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:14:25 -0500
Message-ID: <4378F021.3060705@perkel.com>
Date: Mon, 14 Nov 2005 12:14:25 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: High load levels - but not really
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a strange problem on one of my spam filter servers. Programs like 
top and xosview are showing very high load levels but I don't actually 
believe the load levels are all that high. Levels have run up as high as 
250 but the computer is still very responsive, not really sluggish at 
all, memory usage is very low, and CPU on the xosview graphs look less 
that 50% busy.

It is an ASUS motherboard with a dual core Athlon X2 and nVidia chipset. 
I just installed 2.6.14.2 kernel to see if that would fix it and it 
didn't. The computer works fine except that the load it's reporting is 
10x what I think it really is.

Anyone else seen this?

