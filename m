Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315192AbSEVWOI>; Wed, 22 May 2002 18:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSEVWOH>; Wed, 22 May 2002 18:14:07 -0400
Received: from freeside.toyota.com ([63.87.74.7]:45320 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S315192AbSEVWOG>; Wed, 22 May 2002 18:14:06 -0400
Message-ID: <3CEC1828.5050209@lexus.com>
Date: Wed, 22 May 2002 15:14:00 -0700
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020519
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Have the 2.4 kernel memory management problems on large machines
In-Reply-To: <E17AakK-0002UE-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>Huh? RH 7.3 kernel has the O(1) scheduler merged?
>>
>>If the RH kernel is anything like the 2.4.19-pre8-ac5
>>I'm currently running, that is  sweet indeed.
>>    
>>
>
>rpm -q --changelog |grep "O(1)"
>
>  
>
Yes, I was being lazy - but now that finals
are done with for now, I'll grab that kernel
source rpm and have a proper look at it.

Thanks,

Joe

