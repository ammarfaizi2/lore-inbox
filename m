Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267195AbSLKQCG>; Wed, 11 Dec 2002 11:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbSLKQCG>; Wed, 11 Dec 2002 11:02:06 -0500
Received: from dhcp5.colorado-research.com ([65.171.192.245]:12933 "EHLO
	dhcp5.colorado-research.com") by vger.kernel.org with ESMTP
	id <S267195AbSLKQCF>; Wed, 11 Dec 2002 11:02:05 -0500
Message-ID: <3DF76302.7040503@cora.nwra.com>
Date: Wed, 11 Dec 2002 09:08:34 -0700
From: Orion Poplawski <orion@cora.nwra.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: scott@thomasons.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Reliable hardware
References: <3DF6291C.3090100@cora.nwra.com> <1039554145.14175.70.camel@irongate.swansea.linux.org.uk> <200212102000.54287.scott@thomasons.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scott thomason wrote:

>On Tuesday 10 December 2002 03:00 pm, Alan Cox wrote:
>  
>
>>Random lockups on dual athlons are a notorious problem under all
>>OS's. Start by checking it passes memtest86, that will verify the
>>RAM is ok - and the AMD is -very- picky about RAM.
>>
>>If thats ok then let me know which board you have, what is plugged
>>into it and what PSU you are using.
>>    
>>
>
>I have two AMD MP 2000+ cpus in an ASUS A7M266-D. Even after returning 
>my memory for new chips the store owner memtest86'd, my combo of cpus 
>and mobo was finding the occasional error. I finally ended up 
>resolving it by simply underclocking the bus about 6Mhz :( 
>
>Next time, I'm buying ECC memory.
>---scott
>  
>
Is there a good site for pointers towards assembling reliable Linux 
machines?  It seems to me the trickiest part of the whole operation is 
choosing good hardware in the first place.  I just started a new job and 
inherited a buch of new but flakey machines, and I'd like to avoid doing 
that in the future.


