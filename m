Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268643AbTCCToD>; Mon, 3 Mar 2003 14:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268660AbTCCToD>; Mon, 3 Mar 2003 14:44:03 -0500
Received: from ip252-142.choiceonecom.com ([216.47.252.142]:28176 "EHLO
	explorer.reliacomp.net") by vger.kernel.org with ESMTP
	id <S268643AbTCCToC>; Mon, 3 Mar 2003 14:44:02 -0500
Message-ID: <3E63B227.8030101@cendatsys.com>
Date: Mon, 03 Mar 2003 13:51:03 -0600
From: Edward King <edk@cendatsys.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Soeren Sonnenburg <kernel@nn7.de>
CC: Mikael Pettersson <mikpe@user.it.uu.se>, szepe@pinerecords.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21pre4-ac5 status report
References: <200303011252.h21CqBpl013357@harpo.it.uu.se> <1046523858.26074.7.camel@sun>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Soeren Sonnenburg wrote:

>On Sat, 2003-03-01 at 13:52, Mikael Pettersson wrote:
>  
>
>>On 01 Mar 2003 11:47:39 +0100, Soeren Sonnenburg wrote:
>>    
>>
>>>As I guessed. I've got two pdc20268 with just one drive per channel
>>>(where the last drive is a cdrom-drive)
>>>
>>>So one pdc no problem >1 -> trouble.
>>>      
>>>
>>Maybe that's changed in 2.4.21-pre-ac new IDE code, I don't know.
>>
>>Your cards don't share interrupts with anything else I hope?
>>    
>>
I tried  two pdc20268's which failed miserably

Used an Asus motherboard and an FIC motherboard, different cables, 
different cards, different powersupply.Hard drives are 200GB western 
digitals, one drive per channel.  

Tried an SIIG card with the SiI680 chipset -- same problem using is and 
the pdc20268, but is more stable than a single pdc -- so now I have 4 
drives on that card.

My kernel is 2.4.21-pre4-ac6 -- let me know if the pre5's solve the problem.

Ed King

