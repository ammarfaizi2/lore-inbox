Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267022AbSLXAXq>; Mon, 23 Dec 2002 19:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbSLXAXp>; Mon, 23 Dec 2002 19:23:45 -0500
Received: from vsmtp4.tin.it ([212.216.176.224]:15258 "EHLO smtp4.cp.tin.it")
	by vger.kernel.org with ESMTP id <S267022AbSLXAXo>;
	Mon, 23 Dec 2002 19:23:44 -0500
Message-ID: <3E07AB4D.8030703@tin.it>
Date: Tue, 24 Dec 2002 01:33:17 +0100
From: AnonimoVeneziano <voloterreno@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021218 Debian/1.2.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: black666@inode.at
CC: linux-kernel@vger.kernel.org
Subject: Re: vt8235 fix, hopefully last variant
References: <20021219112640.A21164@ucw.cz> <200212232242.20382.black666@inode.at> <3E07A5AC.3060201@tin.it> <200212240126.46794.black666@inode.at>
In-Reply-To: <200212240126.46794.black666@inode.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Petermair wrote:

>AnonimoVeneziano:
>
>  
>
>>>What is it exactly that doesn't work? The patching, compiling,
>>>booting, dma,...?
>>>
>>>      
>>>
>>The patching .... it said something about HUNKS failed....
>>    
>>
>
>It's normal that Hunk 1 and 2 fail... Hunk 3 is the important one. So 
>you can compile the kernel even with Hunks 1&2 failing.
>
>Quote from Vojtech:
>-----
>
>  
>
>>I tried the last patch, but it didn't work - I got Hunk messages:
>>
>>starbase:/usr/src/linux-2.4.20# patch -p1 < vt8235-atapi 
>>patching file drivers/ide/via82cxxx.c
>>Hunk #1 FAILED at 1.
>>Hunk #2 FAILED at 141.
>>Hunk #3 succeeded at 283 (offset -57 lines).
>>2 out of 3 hunks FAILED -- saving rejects to file 
>>starbase:/usr/src/linux-2.4.20# 
>>    
>>
>
>Since they're in comments only, you can ignore them.
>
>-----
>
>Patrick
>
>
>  
>
Ah, ok, thank you very much, tomorrow I'll try to compile.I've tried to 
compile the patch vt8235-min (with 2 hunks failed) but It wasn't work. 
With vt8235-atapi I haven't tried at all when I've saw the failed hunks. 
I haven't compile.

Thank you

Bye

Marcello

