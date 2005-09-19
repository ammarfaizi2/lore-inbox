Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVISU4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVISU4b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 16:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbVISU4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 16:56:31 -0400
Received: from mail.tmr.com ([64.65.253.246]:65426 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932390AbVISU4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 16:56:30 -0400
Message-ID: <432F2602.1020200@tmr.com>
Date: Mon, 19 Sep 2005 16:56:34 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Pierre Ossman <drzeus-list@drzeus.cx>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ipw2200 using old wireless extensions
References: <4329E09B.9020807@drzeus.cx> <432F0BC6.3040100@tmr.com> <432F1280.3040209@pobox.com>
In-Reply-To: <432F1280.3040209@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Bill Davidsen wrote:
>
>> Pierre Ossman wrote:
>>
>>> With the inclusion of the ipw2200 driver and the update of the wireless
>>> extensions I get my dmesg flooded with these:
>>>
>>> eth0 (WE) : Driver using old /proc/net/wireless support, please fix 
>>> driver !
>>>
>>> Somebody please make the hurting go away :)
>>
>>
>>
>> Is this related to using the old 1.0.0 driver instead of current? I 
>> asked why and never got an answer, so ???
>
>
> Because we're waiting on Intel, or someone, to update the driver 
> properly. 


Okay, I'll continue to do the upgrade manually.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

