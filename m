Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVJBWzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVJBWzM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 18:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVJBWzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 18:55:12 -0400
Received: from postman2.arcor-online.net ([151.189.20.157]:60911 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S1750828AbVJBWzK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 18:55:10 -0400
Message-ID: <43406552.9050708@arcor.de>
Date: Mon, 03 Oct 2005 00:55:14 +0200
From: =?UTF-8?B?RnJpZWRlciBCw7xyemVsZQ==?= <linux-stuff@arcor.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: oops in ohci_hcd with kernel 2.6.12 - 2.6.14-rc3-git2
References: <4340518D.8050701@arcor.de>
In-Reply-To: <4340518D.8050701@arcor.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>> On Sun, Oct 02, 2005 at 05:37:06PM +0200, Frieder B??rzele wrote:
>>
>>> Hi,
>>>
>>> since kernel version ~2.6.12 I occasionally get oopes with the ohci_hcd
>>> modul during boot.
>>> I need to reboot 5 times or more until the machine works.
>>>
>>> mainboard is a Asus A7N266-C with nforce chipset
>>
>>
>> Care to file this in a bug at bugzilla.kernel.org?
>>
>> thanks,
>>
>> greg k-h
>>
> k thx will do this soon
>
filled a bug:
http://bugzilla.kernel.org/show_bug.cgi?id=5350
