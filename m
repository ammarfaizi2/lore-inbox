Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWITHpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWITHpk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 03:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWITHpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 03:45:36 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:46726 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S1751280AbWITHpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 03:45:33 -0400
From: Allan Zhong <allanz@cse.unsw.EDU.AU>
To: linux-kernel@vger.kernel.org
Date: Wed, 20 Sep 2006 17:45:30 +1000 (EST)
X-X-Sender: allanz@wagner.orchestra.cse.unsw.EDU.AU
Subject: LSR safety check engaged.
In-Reply-To: <Pine.LNX.4.64.0609200308100.14271@wagner.orchestra.cse.unsw.EDU.AU>
Message-ID: <Pine.LNX.4.64.0609201734500.28776@wagner.orchestra.cse.unsw.EDU.AU>
References: <Pine.LNX.4.64.0609200308100.14271@wagner.orchestra.cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After i've compile the kernel, didn't even adjust any parameters in the 
make menuconfig. I've installed the new debian kernel. I get this error 
concerning my serial ports. I ran the dmesg and it states

"ttyS0: LSR safety check engaged!"
"ttyS2: LSR safety check engaged!"

Anyone know how i can correct this problem. I've did a few googling around 
and found that LSR is the name of a hardware register. This error meant 
that there was no serial port at the address where the drivers think my 
serial port is located. I can't seem to find a solution to my problem, is 
there anyone out there who knows how i can correct this?

Any help will be greatly appreciated.

Thanks,
Allan

