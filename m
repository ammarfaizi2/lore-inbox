Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbUAEMcx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 07:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbUAEMcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 07:32:53 -0500
Received: from chiapa.terra.com.br ([200.154.55.224]:58561 "EHLO
	chiapa.terra.com.br") by vger.kernel.org with ESMTP id S264414AbUAEMcu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 07:32:50 -0500
Message-ID: <3FF959A3.5020408@eps.ufsc.br>
Date: Mon, 05 Jan 2004 10:33:39 -0200
From: Job <job@eps.ufsc.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Steinmetz <ast@domdv.de>
Cc: Andre Hedrick <andre@linux-ide.org>, tomwallard@soon.com,
       linux-kernel@vger.kernel.org
Subject: Re: Any hope for HPT372/HPT374 IDE controller?
References: <Pine.LNX.4.10.10401041431520.31033-100000@master.linux-ide.org> <3FF8B35E.1050704@domdv.de>
In-Reply-To: <3FF8B35E.1050704@domdv.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use KT400 MoBo, my HD is at HighPoint IDE, I am not using RAID and
works fine with apic=off, but did not boot on 2.6 kernel series due the 
lack of ataraid or some scripts.


Andreas Steinmetz wrote:

> Andre Hedrick wrote:
>
>>
>> Some of the problems appear with the APIC routing and interrupts being
>> lost and not begin processed.
>>
>
> Hopefully this will solve problems for X86-64 AMD chipset based MoBos 
> too. I can run my Tyan S2885 only with IO-APIC disabled due to HPT302 
> lockups (2.4)/lost interrupts (2.6).


