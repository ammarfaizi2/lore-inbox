Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbULHHHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbULHHHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 02:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbULHHHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 02:07:19 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:17807 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262039AbULHHHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 02:07:13 -0500
Message-ID: <41B6A837.4030505@jp.fujitsu.com>
Date: Wed, 08 Dec 2004 16:07:35 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH] IRQ resource deallocation[0/2]
References: <41B559DD.7040307@jp.fujitsu.com> <Pine.LNX.4.61.0412070820240.13396@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0412070820240.13396@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

> On Tue, 7 Dec 2004, Kenji Kaneshige wrote:
> 
>> I had posted the IRQ resource deallocation patch a couple of monthes
>> ago and I had incorporated all feedbacks from the mailing list
>> (http://marc.theaimsgroup.com/?l=linux-kernel&m=109688530703122&w=2).
>> But it doesn't seems to be included yet, so I would like to try again.
>> I hope my patch is included onto -mm tree since I want the patches
>> be tested by many people.
> 
> You should remove the config option and make it unconditional.
> 

I think you're right. I'll update the patch.

Thanks,
Kenji Kaneshige

