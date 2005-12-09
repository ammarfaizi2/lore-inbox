Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbVLIRzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbVLIRzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 12:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVLIRzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 12:55:22 -0500
Received: from smtpout.mac.com ([17.250.248.86]:38611 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964833AbVLIRzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 12:55:21 -0500
In-Reply-To: <1134148609.30856.22.camel@localhost>
References: <r02010500-1043-55BAAD4668D211DA98840011248907EC@[10.64.61.57]> <1134148609.30856.22.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E4ECF4F0-9442-4FFE-BE55-3EF7A1CC40F4@mac.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: Re: [PATCH 2.6.15-rc5] hugetlb: make make_huge_pte global and fix coding style
Date: Fri, 9 Dec 2005 11:55:19 -0600
To: Dave Hansen <haveblue@us.ibm.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 9, 2005, at 11:16 AM, Dave Hansen wrote:

> What driver needs to map huge pages?  Is it in the kernel tree  
> now?  If
> not, can you post the source, please?

It is a funky driver for an embedded system. I can't imagine it ever  
being in the kernel tree, because not many people want to share 768M  
of contiguous physical memory.

I can post the source, but it really is a bunch of random stuff for  
am embedded application. We do make it available as part of our GPL  
source release to customers.

-- 
Mark Rustad, MRustad@mac.com

