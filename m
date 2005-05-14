Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbVENIrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbVENIrs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 04:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVENIrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 04:47:48 -0400
Received: from rly-ip03.mx.aol.com ([64.12.138.7]:15551 "EHLO
	rly-ip03.mx.aol.com") by vger.kernel.org with ESMTP id S262708AbVENIro
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 04:47:44 -0400
Message-ID: <4285C030.1080706@yahoo.co.uk>
Date: Sat, 14 May 2005 10:09:04 +0100
From: christos gentsis <christos_gentsis@yahoo.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Bill Davidsen <davidsen@tmr.com>, linux-os@analogic.com,
       "Srinivas G." <srinivasg@esntechnologies.co.in>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: Y2K-like bug to hit Linux computers! - Info of the day
References: <4EE0CBA31942E547B99B3D4BFAB348114BED13@mail.esn.co.in> <200505131522.32403.vda@ilport.com.ua> <Pine.LNX.4.61.0505130825310.4428@chaos.analogic.com> <Pine.LNX.4.61.0505130837390.4781@chaos.analogic.com>            <42850FC7.7010603@tmr.com> <200505132047.j4DKlcgV025923@turing-police.cc.vt.edu>
In-Reply-To: <200505132047.j4DKlcgV025923@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 195.93.24.101
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>On Fri, 13 May 2005 16:36:23 EDT, Bill Davidsen said:
>  
>
>>>Mon Jan 18 22:14:07 EST 2038
>>>Fri Dec 13 15:46:09 EST 1901
>>>      
>>>
>>                 ^^^^^ are UTC and GMT that far apart? Leap seconds? WTF?
>>    
>>
>
>The heck with leap seconds - why did it warp back to 1901 rather
>than to 1969/1970? ;)
>  
>
because it look like the time is a signed number... but shall i ask how 
counting something that increase can give a negative number?
second... is the counter on the software? until now i thought that the 
counter is a clock on the hardware... so how is this related with Linux? 
then the counter overflow... this will be a hardware issue... not a 
software issue ( the software will have to support the bigger hardware 
counter but to do that the bigger hardware has to exist first...)

BTW is there anyone that plan to use his embedded devise until 2038???? 
i would happy to see that :P any way embedded devises are there so they 
will have sort life cycle... how long are you going to use them 6 
months???? maximum 1-2 years....
so there is no any problem....

