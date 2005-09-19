Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932554AbVISTd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbVISTd2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbVISTd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:33:28 -0400
Received: from mail.dvmed.net ([216.237.124.58]:35726 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932554AbVISTd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:33:27 -0400
Message-ID: <432F1280.3040209@pobox.com>
Date: Mon, 19 Sep 2005 15:33:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Pierre Ossman <drzeus-list@drzeus.cx>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ipw2200 using old wireless extensions
References: <4329E09B.9020807@drzeus.cx> <432F0BC6.3040100@tmr.com>
In-Reply-To: <432F0BC6.3040100@tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> Pierre Ossman wrote:
> 
>> With the inclusion of the ipw2200 driver and the update of the wireless
>> extensions I get my dmesg flooded with these:
>>
>> eth0 (WE) : Driver using old /proc/net/wireless support, please fix 
>> driver !
>>
>> Somebody please make the hurting go away :)
> 
> 
> Is this related to using the old 1.0.0 driver instead of current? I 
> asked why and never got an answer, so ???

Because we're waiting on Intel, or someone, to update the driver properly.

	Jeff


