Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVCZU45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVCZU45 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 15:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVCZU44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 15:56:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:59876 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261257AbVCZU4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 15:56:55 -0500
Message-ID: <4245CC80.10306@osdl.org>
Date: Sat, 26 Mar 2005 12:56:32 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andy Whitcroft <apw@shadowen.org>
Subject: Re: [RFC][PATCH 1/4] create mm/Kconfig for arch-independent memory
 options
References: <E1DEwlP-0006BQ-00@kernel.beaverton.ibm.com>	 <4244D068.3080900@osdl.org> <1111863649.9691.100.camel@localhost>
In-Reply-To: <1111863649.9691.100.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Fri, 2005-03-25 at 19:00 -0800, Randy.Dunlap wrote:
> ...
> 
>>>+config DISCONTIGMEM
>>>+	bool "Discontigious Memory"
>>>+	depends on ARCH_DISCONTIGMEM_ENABLE
>>>+	help
>>>+	  If unsure, choose this option over "Sparse Memory".
>>
>>Same question....
> 
> 
> It's in the third patch in the series.  They were all together at one
> point and I was trying to be lazy, but you caught me :)

I wasn't trying to catch you, but I've already looked at
all 4 patches in the series and I still can't find an
option that is labeled/described as "Sparse Memory"....
The word "sparse" isn't even in patch 3/4... maybe
there is something missing?

-- 
~Randy
