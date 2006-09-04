Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWIDR01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWIDR01 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 13:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWIDR01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 13:26:27 -0400
Received: from mail.tmr.com ([64.65.253.246]:18837 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S964954AbWIDR00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 13:26:26 -0400
Message-ID: <44FC62EF.7040100@tmr.com>
Date: Mon, 04 Sep 2006 13:31:27 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Marc Perkel <marc@perkel.com>, Adam Kropelin <akropel1@rochester.rr.com>,
       Jeff Garzik <jeff@garzik.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux RAID Mailing List <linux-raid@vger.kernel.org>
Subject: Re: Linux: Why software RAID?
References: <20060824090741.J30362@mail.kroptech.com>	 <1156425650.3007.140.camel@localhost.localdomain>	 <44EDB843.2020608@perkel.com> <1156432892.3007.155.camel@localhost.localdomain>
In-Reply-To: <1156432892.3007.155.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>Ar Iau, 2006-08-24 am 07:31 -0700, ysgrifennodd Marc Perkel:
>  
>
>>So - the bottom line answer to my question is that unless you are
>>running raid 5 and you have a high powered raid card with cache and
>>battery backup that there is no significant speed increase to use
>>hardware raid. For raid 0 there is no advantage.
>>
>>    
>>
>If your raid is entirely on PCI plug in cards and you are doing RAID1
>there is a speed up using hardware assisted raid because of the PCI bus
>contention.
>

I would expect to see this with RAID5 as well, for the same reason...

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

