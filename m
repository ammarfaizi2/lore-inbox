Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWCNQYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWCNQYR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbWCNQYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:24:17 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:12810 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750903AbWCNQYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:24:16 -0500
Message-ID: <4416EDBF.3070609@vmware.com>
Date: Tue, 14 Mar 2006 08:22:23 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 0/24] VMI i386 Linux virtualization interface proposal
References: <200603131758.k2DHwQM7005618@zach-dev.vmware.com> <441642EE.80900@us.ibm.com> <4416460A.2090704@vmware.com> <Pine.LNX.4.63.0603132329160.17874@cuia.boston.redhat.com> <441658A2.4090905@vmware.com> <Pine.LNX.4.63.0603140742530.31791@cuia.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.63.0603140742530.31791@cuia.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Mon, 13 Mar 2006, Zachary Amsden wrote:
>
>   
>> There is a Signed-off-by line on every patch I send out,
>>     
>
> You're right.  It was just the first 1/24 that was missing it,
> it was there in the second copy.
>   

BTW, I have no idea why the first 1/24 was missing it.  I checked right 
before sending, and it was there - perhaps I forgot to save my changes.  
The second copy turned out fine, but didn't make it to LKML.  Everyone 
cc'd directly got it, but the LKML filter has a ban on the word 
propasition, and being blackholed by it, I merely assumed the patch was 
too large - so I split it up, and actually ended up binary searching 
down to the problematic section before finding the taboo list.

_Every_  problem eventually turns into a binary search.

Zach
