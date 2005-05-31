Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVEaCML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVEaCML (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 22:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVEaCML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 22:12:11 -0400
Received: from mail.avantwave.com ([210.17.210.210]:49820 "EHLO
	mail.avantwave.com") by vger.kernel.org with ESMTP id S261862AbVEaCFu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 22:05:50 -0400
Message-ID: <429BC678.7060403@avantwave.com>
Date: Tue, 31 May 2005 10:05:44 +0800
From: Tomko <tomko@avantwave.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: abonilla@linuxwireless.org, linux-kernel@vger.kernel.org
Subject: Re: question : 802.11b WLAN stack in linux
References: <001001c56512$a13d4110$600cc60a@amer.sykes.com>
In-Reply-To: <001001c56512$a13d4110$600cc60a@amer.sykes.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thx for your reply.

Actually i want to use wireless LAN in my embedded linux, i would like 
to use Philip BGW200 WLAN chip as the wireless module. Except the 
adapter for this module , do i need to download and plug-in WLAN stack 
to the kernel or i can just choose to support wlan simply in the 
menuconfig ?

Hope somebody can give me a hand.

Regards,
TOM

Alejandro Bonilla wrote:

>>Hi all
>>
>>Do linux support WLAN stack ? i find in menuconfig but seems
>>no there.
>>Do anyone know if there any stack and driver adapter of
>>wireless in linux ?
>>    
>>
>
>Of course there are. If you are only talking about a stack, I believe that
>people are working on the ieee80211 stack specifically and if you are
>talking about supported adapters, just go to Network Devices and Wireless
>and you should see several drivers there to load into the kernel.
>
>I really don't understand your question, So I'm assuming that you want to
>know if Linux has support for wireless cards.
>
>Google can help you further.
>
>.Alejandro
>
>  
>
>>Regards,
>>TOM
>>    
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

