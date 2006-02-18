Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWBRNog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWBRNog (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 08:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWBRNog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 08:44:36 -0500
Received: from mail.tmr.com ([64.65.253.246]:8861 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1751211AbWBRNog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 08:44:36 -0500
Message-ID: <43F7257D.80400@tmr.com>
Date: Sat, 18 Feb 2006 08:47:41 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: mj@ucw.cz, nix@esperi.org.uk, linux-kernel@vger.kernel.org,
       chris@gnome-de.org, axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <43ED005F.5060804@tmr.com> <1139615496.10395.36.camel@localhost.localdomain> <43F088AB.nailKUSB18RM0@burner> <mj+md-20060213.135336.28566.atrey@ucw.cz> <43F0A319.nailKUSXT33MZ@burner>
In-Reply-To: <43F0A319.nailKUSXT33MZ@burner>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:

>Martin Mares <mj@ucw.cz> wrote:
>
>  
>
>>Hello!
>>
>>    
>>
>>>The main problem is that there is no grant that a new model will survive
>>>a time frame that makes sense to implement support.
>>>      
>>>
>>I bet that it would take less time to implement this support than what
>>you spend here by arguing and trying to prove you are the only sane
>>person in the world. Unsuccessfully, of course.
>>    
>>
>
>If memory serves me correctly, the current model is the 3rd incompatible one
>offerend within less than 5 years.
>  
>
With that I agree. Not only does the interface change, the details 
within a given interface must change.

>If you did ever try to write reliable code that has to deal with this kind of
>oddities, you would understand that it is sometimes better to wait and to inform
>related people about the problems they caused.
>  
>
This ground has been covered. And at least in the case of filtering 
commands, that had to be done quickly and you know it.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

