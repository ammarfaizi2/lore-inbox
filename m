Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318783AbSIPDiv>; Sun, 15 Sep 2002 23:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318785AbSIPDiv>; Sun, 15 Sep 2002 23:38:51 -0400
Received: from fwb.seaplace.org ([209.184.155.45]:34176 "EHLO
	lynn.dmz.seaplace.org") by vger.kernel.org with ESMTP
	id <S318783AbSIPDiu>; Sun, 15 Sep 2002 23:38:50 -0400
Message-ID: <3D85536C.1070108@seaplace.org>
Date: Sun, 15 Sep 2002 22:43:40 -0500
From: "Kevin N. Carpenter" <kevinc@seaplace.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ahmed Masud <masud@googgun.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Think 2.4.10 broke my PCI subsystem - resolved.
References: <200209150529.g8F5Tgh14760@lynn.seaplace.org> <3D8451DD.4050106@googgun.com> <3D847E95.9040602@seaplace.org> <3D850523.70608@googgun.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.20-pre7 fixes whatever the problem was.  Kernels between 2.4.10 and 
2.4.19 were broke for these mobo.

Did notice a new message:  Using IRQ router SIS [1039/0008]

Thanks to whomever fixed it!

Kevin C.

Ahmed Masud wrote:

> Kevin N. Carpenter wrote:
>
>> Thats the whole point.  Nothing past 2.4.9 will run on these mobos.
>>
>> Do appreciate the consideration.
>>
>> Kevin C.
>>
>> Ahmed Masud wrote:
>>
>>> Kevin Carpenter wrote:
>>>
>>>> I've recently been okaying around with low cost motherboards and 
>>>> have been
>>>> problems on two of them:  the BIOSTAT micro-ATX mobo M7VKQ, and the 
>>>> ESC L7SOM
>>>> mobos.
>>>>
> Wait ... you say that already :) sorry....
>
>


