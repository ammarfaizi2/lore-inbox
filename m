Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbTLXP1d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 10:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbTLXP1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 10:27:33 -0500
Received: from cpc3-hitc2-5-0-cust116.lutn.cable.ntl.com ([81.99.82.116]:50399
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S263697AbTLXP1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 10:27:31 -0500
Message-ID: <3FE9B3AF.3090507@reactivated.net>
Date: Wed, 24 Dec 2003 15:41:35 +0000
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Updated Lockup Patches, 2.6.0 Nforce2, apic timer ack delay,
 ioapic edge for NMI debug
References: <200312211917.05928.ross@datscreative.com.au> <3FE73CF6.4030207@reactivated.net> <200312230948.24162.ross@datscreative.com.au>
In-Reply-To: <200312230948.24162.ross@datscreative.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(also sent to Ross, forgot to CC LKML)...

Ross Dickson wrote:
 > On Tuesday 23 December 2003 04:50, Daniel Drake wrote:
 >
 >> I then recompiled the kernel with your patches and since then it's been fine.
I spoke to soon. After your two newest patches (APIC & IOAPIC from thread 
starting mail) the system did freeze again (twice) after several hours of 
usage each time. I have been running with apic_tack=2 since then and have not 
experienced any lockups.

 > 2.6.0-test11-mm1 picked up the earlier two patches which were the topic
 > of "Catching NForce2 lockup with NMI watchdog"
 >
 > Others had reported that those patches achieved stability?
Not for me.

Thanks

-Daniel
