Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312284AbSCTXcV>; Wed, 20 Mar 2002 18:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312287AbSCTXcM>; Wed, 20 Mar 2002 18:32:12 -0500
Received: from smtp-2.llnl.gov ([128.115.250.82]:55178 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id <S312285AbSCTXb5>;
	Wed, 20 Mar 2002 18:31:57 -0500
Message-ID: <3C991BE6.70504@llnl.gov>
Date: Wed, 20 Mar 2002 15:31:50 -0800
From: "Tom Epperly" <tepperly@llnl.gov>
Organization: Lawrence Livermore National Laboratory
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020314
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bad Illegal instruction traps on dual-Xeon (p4) Linux Dell box
In-Reply-To: <E16npXs-0003el-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>I initiated a support call with Dell at around 3:30pm PST on Friday
>>15-Mar-2002, and all the feedback I've received from this so far shows
>>that they are clueless. They are trying to portray this as a Linux
>>problem.
>>
>
>Well to be honest they aren't the only ones who are totally baffled by it.
>Do you have the current microcode updates in your BIOS or via the ucode
>driver ?
>
One box, tux06, has the latest Dell BIOS, A05. I don't know how to 
determine if it has the latest microcode updates. Where can one get the 
current microcode updates, and how do I install it?

>
>
>Do all the problem boxes have the same stepping of CPU ?
>
According to cat /proc/cpuinfo, two boxes tux06 & tux34 have stepping 
10, and tux47 has stepping 2. I have seen the unexplained "Illegal 
instruction" messages on tux34 and tux47, but I haven't run the modified 
kernel on them. root access is restricted here.

Tom

