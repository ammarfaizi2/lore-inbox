Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311376AbSCMVLe>; Wed, 13 Mar 2002 16:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311375AbSCMVLP>; Wed, 13 Mar 2002 16:11:15 -0500
Received: from freeside.toyota.com ([63.87.74.7]:8199 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S311376AbSCMVK6>; Wed, 13 Mar 2002 16:10:58 -0500
Message-ID: <3C8FC054.2000009@lexus.com>
Date: Wed, 13 Mar 2002 13:10:44 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Ford <david+cert@blue-labs.org>
CC: linux <linux-kernel@vger.kernel.org>
Subject: Re: uname reports 'unknown'
In-Reply-To: <1015897420.3054.0.camel@coredump> <3C8D8F35.7090608@tmsusa.com> <3C8FA7FA.1030103@blue-labs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So it would seem, since the fix is easy...

Maybe it's a portability concern...

Joe



David Ford wrote:

> Seems to me that it is the fault of the original package of 'sh-utils'.
>
> -d
>
> J Sloan wrote:
>
>> Shawn Starr wrote:
>>
>>> Linux coredump 2.4.19-pre2-ac4-xfs-shawn10 #2 Mon Mar 11 03:36:35 EST
>>> 2002 i586 unknown
>>>
>>>
>>> what should 'unknown' really be? I've never seen it different on Intel
>>> systems.
>>>
>>
>> Many vendors ship a broken sh-utils.
>>
>> They don't have to:
>>
>> Linux neo.mirai.cx 2.4.19-pre2aa1 #1 Fri Mar 8 19:55:24 PST 2002 i686 
>> GenuineIntel
>>
>> Linux emerald.mirai.cx 2.4.19pre1aa1 #1 Sat Mar 2 20:55:06 PST 2002 
>> i586 AuthenticAMD
>>
>> Cheers,
>>
>> Joe
>
>
>
>


