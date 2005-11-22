Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbVKVX1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbVKVX1m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 18:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbVKVX1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 18:27:42 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:19365 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030248AbVKVX1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 18:27:41 -0500
Message-ID: <4383A936.8020507@us.ibm.com>
Date: Tue, 22 Nov 2005 15:26:46 -0800
From: Darren Hart <dvhltc@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "lkml, " <linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>
Subject: kthrt vs rt13
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to determine which ktimers / hrt related patches are part of the rt 
series of patches and having some diffculty doing so.  I've heard it said that 
the wish is for people to evaluate the rt series as a standalone patch, rather 
than a collection of others.  I can understand this point of view, but in the 
case where someone is migrating from a kthrt kernel to an rt kernel and wants to 
verify that certain bugfixes etc have been applied, it would be very nice to be 
able to see the patch series file.  Can anyone provide such a list?

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Linux Kernel Team

