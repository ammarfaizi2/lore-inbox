Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263892AbTIICt1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 22:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbTIICt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 22:49:27 -0400
Received: from [203.221.72.196] ([203.221.72.196]:17924 "EHLO chimp.local.net")
	by vger.kernel.org with ESMTP id S263892AbTIICt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 22:49:26 -0400
Message-ID: <3F5D3EA5.9080900@cyberone.com.au>
Date: Tue, 09 Sep 2003 12:44:53 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Mike Sullivan <mksully@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I/O degredation with AS on 2.6.0-test3
References: <OF0770DEDD.BEBEF8A2-ON85256D9B.00659B11@us.ibm.com> <1063052763.29025.100.camel@nighthawk>
In-Reply-To: <1063052763.29025.100.camel@nighthawk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dave Hansen wrote:

>You might want to try Martin Bligh's diffprofile utility.  It's a bit
>hard to compare 2 500-line profiles without it.
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/tools/
>
>Also, there have evidently been a few I/O scheduler fixes since -test3. 
>Please retry with -test5.
>

More important, are they regressions vs. previous kernels with AS?


