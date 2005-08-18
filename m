Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbVHSGj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbVHSGj3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 02:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVHSGj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 02:39:29 -0400
Received: from karen.nerdshack.com ([209.189.235.41]:56005 "EHLO
	karen.nerdshack.com") by vger.kernel.org with ESMTP
	id S1751044AbVHSGj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 02:39:28 -0400
Message-ID: <43051C32.4050405@nerdshack.com>
Date: Thu, 18 Aug 2005 23:39:30 +0000
From: smiling_23 <smiling_23@nerdshack.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Timer modification
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
        Can any one know how the "timer_adj" calculation is working in 
timer.c of linuxkernle2.6.12.5
If we change the HZ value to more than 1000. What hapens to the wall 
clock. is there any modification neded in wall closk.
And  i have seen different "time_adj" calculations for HZ 100 and 1000. 
How to change this calculation for new HZ value.
Thanks,
Cjag

