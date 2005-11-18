Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161181AbVKRUch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161181AbVKRUch (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161183AbVKRUc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:32:26 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:47232 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S1161181AbVKRUcG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:32:06 -0500
Message-ID: <437E3426.50608@wolfmountaingroup.com>
Date: Fri, 18 Nov 2005 13:05:58 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <58MJb-2Sn-37@gated-at.bofh.it> <58NvO-46M-23@gated-at.bofh.it>	 <58Rpx-1m6-11@gated-at.bofh.it> <58UGF-6qR-27@gated-at.bofh.it>	 <58UQf-6Da-3@gated-at.bofh.it> <437933B6.1000503@shaw.ca>	 <1132020468.27215.25.camel@mindpipe> <20051115032819.GA5620@redhat.com>	 <43795575.9010904@wolfmountaingroup.com>	 <20051115050658.GA13660@redhat.com>	 <43797E05.5090107@wolfmountaingroup.com> <1132342065.25914.81.camel@localhost.localdomain>
In-Reply-To: <1132342065.25914.81.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Llu, 2005-11-14 at 23:19 -0700, Jeff V. Merkey wrote:
>  
>
>>Making the point that in 1990, folks had grown beyond 4K stacks in 
>>kernels, along with MS DOS 640K Limitations.
>>    
>>
>
>And Linux 8086 uses 512 byte kernel stacks, and really wants a bit of
>tuning to get down to 256.
>
>Its about discipline and design not year
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Amen.

:-)

Jeff
