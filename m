Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317869AbSGWATV>; Mon, 22 Jul 2002 20:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317873AbSGWATV>; Mon, 22 Jul 2002 20:19:21 -0400
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.228]:56536 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S317869AbSGWATU>; Mon, 22 Jul 2002 20:19:20 -0400
Message-ID: <3D3C9FFE.7040204@linux.org>
Date: Mon, 22 Jul 2002 20:14:54 -0400
From: John Weber <john.weber@linux.org>
Organization: Linux Online
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020702
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: New Xircom Cardbus Driver for 2.5?
References: <3D3C8D08.3060107@linux.org> <3D3C9848.4050802@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> John Weber wrote:
> 
>> I searched the archives, but couldn't find anything about the new 
>> xircom 32-bit cardbus driver for linux 2.5.  Can anyone give me some 
>> pointers?
> 
> 
> 
> There is no new xircom cardbus driver.  It has the same drivers as 2.4, 
> "xircom_cb" and "xircom_tulip_cb"  I believe these were in the 
> drivers/net/pcmcia directly in 2.4.
> 
>     Jeff

You're right.  Thanks.

I don't use this driver myself, so I didn't know that there was a new 
tulip config option that needed to be enabled.  I am utterly confused 
about tulip/cardbus/pcmcia/etc... but I will not stop trying to read 
this code :).

Thanks again.




