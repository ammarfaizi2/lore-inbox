Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVDBUp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVDBUp5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 15:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVDBUp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 15:45:57 -0500
Received: from pin.if.uz.zgora.pl ([212.109.128.251]:62690 "EHLO
	pin.if.uz.zgora.pl") by vger.kernel.org with ESMTP id S261273AbVDBUpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 15:45:41 -0500
Message-ID: <424F04C1.7050902@pin.if.uz.zgora.pl>
Date: Sat, 02 Apr 2005 22:46:57 +0200
From: Jacek Luczak <difrost@pin.if.uz.zgora.pl>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: chaosite@gmail.com
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: Something wrong with 2.6.12-rc1-RT-V0.7.43-05
References: <424EEF39.50805@pin.if.uz.zgora.pl> <424EF1D3.1070604@gmail.com> <424EF485.7050004@pin.if.uz.zgora.pl>
In-Reply-To: <424EF485.7050004@pin.if.uz.zgora.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek Luczak napisał(a):
> Matan Peled napisał(a):
> 
>> Jacek Luczak wrote:
>>
>>> Hi
>>>
>>> Early morning i made a 2.6.12-rc1 with RT-V0.7.43-05 and this is what I
>>> sow in dmesg after 6 hours of computers work:
>>>
>>> <SNIP!>
>>
>>
>>
>> Hmm... A lot of that seems to involve ndiswrapper. Is there any way 
>> you could
>> reproduce this without ndiswrapper loaded?
> 
> 
> I will try and send it back.
> 
It seems that everything is involve by ndiswrapper. Those errors 
reappear after module load. Without ndiswrapper kernel works OK.

	Jacek
