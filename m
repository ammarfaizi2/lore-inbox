Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVEaEdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVEaEdY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 00:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVEaEdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 00:33:24 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:19602
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261742AbVEaEdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 00:33:16 -0400
Message-ID: <429BDAF7.4030206@linuxwireless.org>
Date: Mon, 30 May 2005 22:33:11 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Tomko <tomko@avantwave.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: question : 802.11b WLAN stack in linux
References: <001001c56512$a13d4110$600cc60a@amer.sykes.com> <429BC678.7060403@avantwave.com>
In-Reply-To: <429BC678.7060403@avantwave.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomko wrote:

> Thx for your reply.
>
> Actually i want to use wireless LAN in my embedded linux, i would like 
> to use Philip BGW200 WLAN chip as the wireless module. Except the 
> adapter for this module , do i need to download and plug-in WLAN stack 
> to the kernel or i can just choose to support wlan simply in the 
> menuconfig ?

As always, if the adapter is supported in the kernel, just select the 
menuconfig support and compile the source. If it's not in the kernel, 
then google and you might find a driver for it.

Simply google for "BGW200 Linux" or if you have a distro do like "BGW200 
debian"

PS: I don't think this is the place to talk about this.

I hope that helps.

.Alejandro

>
> Hope somebody can give me a hand.
>
> Regards,
> TOM
>
> Alejandro Bonilla wrote:
>
>>> Hi all
>>>
>>> Do linux support WLAN stack ? i find in menuconfig but seems
>>> no there.
>>> Do anyone know if there any stack and driver adapter of
>>> wireless in linux ?
>>>   
>>
>>
>> Of course there are. If you are only talking about a stack, I believe 
>> that
>> people are working on the ieee80211 stack specifically and if you are
>> talking about supported adapters, just go to Network Devices and 
>> Wireless
>> and you should see several drivers there to load into the kernel.
>>
>> I really don't understand your question, So I'm assuming that you 
>> want to
>> know if Linux has support for wireless cards.
>>
>> Google can help you further.
>>
>> .Alejandro
>>
>>  
>>
>>> Regards,
>>> TOM
>>>   
>>
