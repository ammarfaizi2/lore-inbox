Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264725AbTGBVHu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 17:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264740AbTGBVHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 17:07:50 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:18080 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S264725AbTGBVHj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 17:07:39 -0400
Message-ID: <3F034BF3.3010705@rackable.com>
Date: Wed, 02 Jul 2003 14:17:39 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?Q29ybmVsaXVzIEvDtmxiZWw=?= <cornelius.koelbel@gmx.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: Bug in Kernel 2.4.20-8]
References: <3F0139D5.1080602@gmx.de> <1057085646.18955.19.camel@dhcp22.swansea.linux.org.uk> <3F01F052.8070307@gmx.de>
In-Reply-To: <3F01F052.8070307@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 02 Jul 2003 21:22:01.0999 (UTC) FILETIME=[FA6F51F0:01C340DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cornelius Kölbel wrote:

> Alan Cox wrote:
>
>> On Maw, 2003-07-01 at 08:35, Cornelius Kölbel wrote:
>>  
>>
>>> I am using Kernel 2.4.20. I admit, it is the kernel of RedHat 9.
>>> I hope this is not, because RedHat did so much changes to the Kernel
>>>   
>>
>>
>> Always hard to tell. It is worth filing Red Hat kernel bugs in
>> https://bugzilla.redhat.com/bugzilla and picking up current errata
>> kernels if there are newer ones
>>
>>  
>>
>>> I was just typing a mail, when the caps lock light and the scroll 
>>> lock light went on.
>>> Nothing happend anymore. No mouse, no keyboard.
>>> I resetted the computer.
>>>   
>>
>>
>> This is a panic - the machine got itself into a state that could not
>> continue. The flashing lights are giving data in morse (useful for those
>> truely desperate debugging situations only 8))
>>
>>  
>>
> After having watched some other problems, I guess it is due to a bad 
> memory module. (Can this be?)
> I removed this module and since then, I had no proplems anymore.
>

  You might want to try a memory tester.  I recommend either memtst86, 
or ctcs's memtst.
http://www.memtest86.com/
http://sourceforge.net/projects/va-ctcs/

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


