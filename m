Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314555AbSD0Bye>; Fri, 26 Apr 2002 21:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314556AbSD0Byd>; Fri, 26 Apr 2002 21:54:33 -0400
Received: from freeside.toyota.com ([63.87.74.7]:25614 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S314555AbSD0Byd>; Fri, 26 Apr 2002 21:54:33 -0400
Message-ID: <3CCA04C8.4080506@lexus.com>
Date: Fri, 26 Apr 2002 18:54:16 -0700
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020426
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Fran=E7ois_Cami?= <stilgar2k@wanadoo.fr>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre kernels leaking memory? How to debug?
In-Reply-To: <Pine.LNX.4.44.0204261430260.4360-100000@mustard.heime.net> <3CC9F347.6010301@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same here, it's been fairly solid -

Even better though is 2.4.19-pre7-ac2 with the
preempt patch and the mini low latency patch.

Joe

François Cami wrote:

> Roy Sigurd Karlsbakk wrote:
>
>> hi
>>
>> How can I check if my theory about 2.4.19-pre-kernels are leaking 
>> memory? After upgrading from 2.4.17-something, my computer chrashes, 
>> wildswapping, after some time. Quite short too.
>>
>> roy
>>
>
> i've ran 2.4.19pre7 for 10 days straight, never had a crash...
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


