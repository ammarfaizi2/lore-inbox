Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTJSREy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 13:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTJSREx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 13:04:53 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:30206 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261928AbTJSREu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 13:04:50 -0400
Message-ID: <3F92C423.8050403@softhome.net>
Date: Sun, 19 Oct 2003 19:04:35 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Wichert Akkerman <wichert@wiggy.net>
Subject: Re: [2.6 patch] add a config option for -Os compilation
References: <Ip4B.8lT.23@gated-at.bofh.it> <Ip4B.8lT.25@gated-at.bofh.it> <Ip4B.8lT.27@gated-at.bofh.it> <Ip4B.8lT.29@gated-at.bofh.it> <Ip4B.8lT.31@gated-at.bofh.it> <Ip4B.8lT.33@gated-at.bofh.it> <Ip4B.8lT.35@gated-at.bofh.it> <Ip4B.8lT.37@gated-at.bofh.it> <Ip4B.8lT.39@gated-at.bofh.it> <Ip4B.8lT.41@gated-at.bofh.it> <Ip4B.8lT.43@gated-at.bofh.it> <Ip4B.8lT.21@gated-at.bofh.it>
In-Reply-To: <Ip4B.8lT.21@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ihar 'Philips' Filipau wrote:
> Wichert Akkerman wrote:
> 
>> Previously Ihar 'Philips' Filipau wrote:
>>
>>>  The goal of kernel is to provide framework for applications to the 
>>> job well.
>>
>>
>> I doubt anyone using linux for routing would agree with you.
>>
> 
>   This is different matter.
>   This is IO bound task - and I'm not sure how -Os will perform there.
>   But still this depends on routing protocols and their requirements.
> 
>   In any way in this case bottleneck is PCI bus (DMA over PCI from NIC 
> to main memory and back). I bet software will show up in timing tests as 
> taking <10% of whole time.
> 

   Sorry I mean't calculations and alike will take <10%.
   Sure in case of software router 90% of time will be spent in CPU.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

