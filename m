Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316621AbSEVRyz>; Wed, 22 May 2002 13:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316623AbSEVRyy>; Wed, 22 May 2002 13:54:54 -0400
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:61116 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S316621AbSEVRyx>;
	Wed, 22 May 2002 13:54:53 -0400
Message-ID: <3CEBDB6C.5070005@tmsusa.com>
Date: Wed, 22 May 2002 10:54:52 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020520
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Have the 2.4 kernel memory management problems on large machines
 been fixed?
In-Reply-To: <E17AaGD-0002OH-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>I wouldn't bother using RedHat's kernel for this at the moment, 
>>Andrea's tree is where the development work for this area has all
>>been happening recently. He's working on integrating O(1) sched
>>right now, which will get rid of the biggest issue I have with -aa
>>    
>>
>
>Still ? Its been in the Red Hat 7.3 tree since we released it. Its also
>in the -ac tree all nicely merged. I guess your definition of happening
>is my definition of "happened" 8)
>

Huh? RH 7.3 kernel has the O(1) scheduler merged?

If the RH kernel is anything like the 2.4.19-pre8-ac5
I'm currently running, that is  sweet indeed.

Joe

