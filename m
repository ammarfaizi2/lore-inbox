Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293132AbSDXIt2>; Wed, 24 Apr 2002 04:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293131AbSDXIt2>; Wed, 24 Apr 2002 04:49:28 -0400
Received: from [159.226.41.188] ([159.226.41.188]:41737 "EHLO
	gatekeeper.ncic.ac.cn") by vger.kernel.org with ESMTP
	id <S293092AbSDXIt1>; Wed, 24 Apr 2002 04:49:27 -0400
Date: Wed, 24 Apr 2002 16:48:41 +0800
From: "Huo Zhigang" <zghuo@gatekeeper.ncic.ac.cn>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: your mail
Organization: NCIC
X-mailer: FoxMail 3.11 Release [cn]
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-ID: <7754BE281413.AAA6F7A@gatekeeper.ncic.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Thank you.
  There is no oops information available. The mechine is just freezed there deadly. In a machine, when this happens, the beep in its box will beep endlessly.

>
>>   Hi, all.
>>   My cluster go wrong these days. So many times when I "/sbin/reboot" a node, the following message will be displayed on the console.
>> 
>> >INIT: Switching to runlevel: 6
>> >INIT: Send processes the TERM signal
>> >Unable to handle kernel NULL pointer dereference
>>   
>>   What's wrong with my machines?  They are all running linux-2.2.18(SMP-supported) with a kernel module which is a driver of Myricom NIC M3S-PCI64C-2 written by my group.
>>   Thank you in advance 8-)
>>   
>>             Zhigang Huo
>>             zghuo@ncic.ac.cn
>
>Have you tried decoding the oops? Have a look at  
>linux/Documentation/oops-tracing.txt
>
>	Zwane
>
>-- 


