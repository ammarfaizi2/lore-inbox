Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267458AbTBNWkY>; Fri, 14 Feb 2003 17:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267467AbTBNWkY>; Fri, 14 Feb 2003 17:40:24 -0500
Received: from hermes.domdv.de ([193.102.202.1]:58636 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S267458AbTBNWkX>;
	Fri, 14 Feb 2003 17:40:23 -0500
Message-ID: <3E4D7297.8060200@domdv.de>
Date: Fri, 14 Feb 2003 23:49:59 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en, de-de, de
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Sparc IDE in 2.4.20
References: <200302142131.h1ELVX4U004986@darkstar.example.net>
In-Reply-To: <200302142131.h1ELVX4U004986@darkstar.example.net>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
>>>Is IDE known to be broken on Sparc in 2.4.20?  I just got this compile
>>>failiure:
>>>sparc-linux-ld -T arch/sparc/vmlinux.lds arch/sparc/kernel/head.o
>>>arch/sparc/kernel
>>>drivers/ide/idedriver.o: In function `ide_end_drive_cmd':
>>>drivers/ide/idedriver.o(.text+0x11d4): undefined reference to `inw_p'
>>
>>I tested it in 2.4.7 for the last time. It probably bitrotted.
>>Why do you care? I posess the only IDE capable sparc on this planet.
>>Just configure it out, and be happy.
> 
> 
> I'm thinking of building a machine based around Sun's Netra AX-1105
> motherboard, which I thought had a supported IDE controller built in,
> but I could be wrong.
> 

Got a nifty little SunBlade 100 on my desk at work, though it is running 
Solaris. This system has IDE disks so there must be more than one IDE 
capable Sparc on this planet :-)
-- 
Andreas Steinmetz

