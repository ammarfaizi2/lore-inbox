Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293603AbSDXIwf>; Wed, 24 Apr 2002 04:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293596AbSDXIwe>; Wed, 24 Apr 2002 04:52:34 -0400
Received: from [159.226.41.188] ([159.226.41.188]:45577 "EHLO
	gatekeeper.ncic.ac.cn") by vger.kernel.org with ESMTP
	id <S293276AbSDXIvk>; Wed, 24 Apr 2002 04:51:40 -0400
Date: Wed, 24 Apr 2002 16:50:55 +0800
From: "Huo Zhigang" <zghuo@gatekeeper.ncic.ac.cn>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: your mail
Organization: NCIC
X-mailer: FoxMail 3.11 Release [cn]
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-ID: <7754BE2814E9.AAA645E@gatekeeper.ncic.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  I boot all the nodes in my cluster without my driver and it is "insmod"ed manually. 
  Now, I will try to "reboot" my machine after the driver is removed. Great. Thank you. 

>> 
>> >INIT: Switching to runlevel: 6
>> >INIT: Send processes the TERM signal
>> >Unable to handle kernel NULL pointer dereference
>>   
>>   What's wrong with my machines?  They are all running linux-2.2.18(SMP-supported) with a kernel module which is a driver of Myricom NIC M3S-PCI64C-2 written by my group.
>>   Thank you in advance 8-)

>Alan:
>If you boot the machije without your driver, then reboot does the
>same happen ? If not then it may well be your driver has an error but only
>when it closes down



