Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135821AbRDYGdx>; Wed, 25 Apr 2001 02:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135822AbRDYGdn>; Wed, 25 Apr 2001 02:33:43 -0400
Received: from james.kalifornia.com ([208.179.59.2]:32865 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S135821AbRDYGda>; Wed, 25 Apr 2001 02:33:30 -0400
Message-ID: <3AE660CE.30801@kalifornia.com>
Date: Tue, 24 Apr 2001 22:29:50 -0700
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-14 i686; en-US; rv:0.8.1+) Gecko/20010420
X-Accept-Language: en
MIME-Version: 1.0
To: imel96@trustix.co.id
CC: Daniel Stone <daniel@kabuki.openfridge.net>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.33.0104242018410.16215-100000@tessy.trustix.co.id>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

imel96@trustix.co.id wrote:

>
>
>On Tue, 24 Apr 2001, Daniel Stone wrote:
>
>>Hence, Microsoft Windows. It might not be stable, it might not be fast, it
>>might not do RAID, packet-filtering and SQL, but it does a job. A simple
>>job. To give Mum & Dad(tm) (with apologies to maddog) a chance to use a
>>computer.
>>
>>
>>Since when, did mobile phones == computers?
>>
>
>read the news! i'm programming nokia 9210 with c++, is that
>computer enough?
>

If that is what this discussion is about, you may just be better off 
with a custom program to run instead of init.  Have you ever booted with 
init=/bin/bash?  Notice how it doesn't require a password . . . Use your 
own program here and you have no need of butchering the kernel.  Be much 
easier to maintain as well.

-b

-- 
Three things are certain:
Death, taxes, and lost data
Guess which has occurred.
- - - - - - - - - - - - - - - - - - - -
Patched Micro$oft servers are secure today . . . but tomorrow is another story!



