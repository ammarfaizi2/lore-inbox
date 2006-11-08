Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965918AbWKHP2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965918AbWKHP2i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 10:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965922AbWKHP2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 10:28:38 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:16874 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S965918AbWKHP2h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 10:28:37 -0500
Message-ID: <4551F798.7020105@gmail.com>
Date: Wed, 08 Nov 2006 16:28:24 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Stephen.Clark@seclark.us
CC: linux-kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
Subject: Re: New laptop - problems with linux
References: <4551EC86.5010600@seclark.us> <4551F3A6.8040807@gmail.com> <4551F5B7.1050709@seclark.us>
In-Reply-To: <4551F5B7.1050709@seclark.us>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Clark wrote:
> Jiri Slaby wrote:
> 
>> Stephen Clark wrote:
>>  
>>
>>> Hi list,
>>>
>>> I just purchased a VBI-Asus S96F laptop Intel 945GM &  ICH7, with a Core
>>> 2 Duo T560,0 2gb pc5400 memory.
>>> From checking around it appeared all the
>>> hardware was well supported by linux - but I am having major problems.
>>>
>>>
>>> 1. neither the wireless lan Intel pro 3945ABG or built in ethernet
>>> RTL-8169C are detected and configured
>>>   
>>
>> If you searched the web, you would get ipw3945 sourceforge homepage in
>> return --
>> it's not in the vanilla kernel for the time being.
>>
>> Is r8169 module loaded?
>>
>>  
>>
> No it is not loaded - i did a modprobe on it and it loaded but still no
> ethx device.

Heh, 2.6.18.1 is too old kernel :D -- it doesn't support this card yet.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
