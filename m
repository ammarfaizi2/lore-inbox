Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268052AbTAIXIw>; Thu, 9 Jan 2003 18:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268050AbTAIXHW>; Thu, 9 Jan 2003 18:07:22 -0500
Received: from adsl-67-113-154-34.dsl.sntc01.pacbell.net ([67.113.154.34]:6384
	"EHLO postbox.aslab.com") by vger.kernel.org with ESMTP
	id <S268055AbTAIXGx>; Thu, 9 Jan 2003 18:06:53 -0500
Message-ID: <3E1E02C1.7060102@aslab.com>
Date: Thu, 09 Jan 2003 15:16:17 -0800
From: Michael Madore <mmadore@aslab.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomas Szepe <szepe@pinerecords.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20 IDE for 2.4.21-pre3
References: <3E1C5EF7.8090004@aslab.com> <20030108182112.GQ823@louise.pinerecords.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe wrote:

>>[mmadore@aslab.com]
>>
>>I get the following oops when running 2.4.21-pre3 + 
>>2.4.21-pre3-2420ide-1.  The oops occurred after running the Cerberus 
>>stress test for about 5 hours.  The machine uses an ASUS A7N8X single 
>>AMD Athlon XP motherboard with the Nvidia nforce2 chipset.  I had to 
>>pass ide0=ata66 ide1=ata66 to the kernel in order to use DMA.
>>    
>>
>
>Michael,
>
>are you able to reproduce this oops with vanilla 2.4.20?
>
>  
>
Actually, we put some different memory in the machine and now it seems 
stable.

Mike


