Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268458AbTCCQlB>; Mon, 3 Mar 2003 11:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268560AbTCCQlA>; Mon, 3 Mar 2003 11:41:00 -0500
Received: from 195-219-31-160.sp-static.linix.net ([195.219.31.160]:54145 "EHLO
	r2d2.office") by vger.kernel.org with ESMTP id <S268458AbTCCQke>;
	Mon, 3 Mar 2003 11:40:34 -0500
Message-ID: <3E6387AE.9080001@walrond.org>
Date: Mon, 03 Mar 2003 16:49:50 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dmesg: Use a PAE enabled kernel
References: <3E63736F.6090000@walrond.org> <26670000.1046707704@[10.10.2.4]>	 <3E6381B9.4090708@walrond.org> <1046713568.6530.32.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mon, 2003-03-03 at 16:24, Andrew Walrond wrote:
> 
>>  BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
> 
> 
> This chunk wont get used
> 
> 

Ouch

That accounts for the missing Gb then. I think the warning needs to be 
more like "WARNING WARNING (WILL ROBINSON)! 1GB of very expensive ram 
won't be used unless you enable PAE!!!"

Just how slow is PAE then ?

Andrew


