Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSDXJpq>; Wed, 24 Apr 2002 05:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311121AbSDXJpp>; Wed, 24 Apr 2002 05:45:45 -0400
Received: from [159.226.41.188] ([159.226.41.188]:40972 "EHLO
	gatekeeper.ncic.ac.cn") by vger.kernel.org with ESMTP
	id <S311025AbSDXJpp>; Wed, 24 Apr 2002 05:45:45 -0400
Date: Wed, 24 Apr 2002 17:44:58 +0800
From: "Huo Zhigang" <zghuo@gatekeeper.ncic.ac.cn>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Re: your mail
Organization: NCIC
X-mailer: FoxMail 3.11 Release [cn]
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-ID: <7754BE291293.AAA6418@gatekeeper.ncic.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Remove the driver first befor reboot! It works. But what is relation between the reboot process and my driver? When I remove the driver module myself, nothing goes wrong. What is the difference?
 
  Thank you. 
  Joining in the lkml is so exciting. :) 
  I love this community.

>> 
>> >INIT: Switching to runlevel: 6
>> >INIT: Send processes the TERM signal
>> >Unable to handle kernel NULL pointer dereference
>>   
>>   What's wrong with my machines?  They are all running linux-2.2.18(SMP-supported) with a kernel module which is a driver of Myricom NIC M3S-PCI64C-2 written by my group.
>>   Thank you in advance 8-)
>
>If you boot the machije without your driver, then reboot does the
>same happen ? If not then it may well be your driver has an error but only
>when it closes down


