Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265114AbTBFRAY>; Thu, 6 Feb 2003 12:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265092AbTBFRAY>; Thu, 6 Feb 2003 12:00:24 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:12494 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S265077AbTBFRAX>; Thu, 6 Feb 2003 12:00:23 -0500
Message-ID: <3E4296BB.2000407@google.com>
Date: Thu, 06 Feb 2003 09:09:15 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephan van Hienen <raid@a2000.nu>
CC: Hans-Peter Jansen <hp@lisa-gmbh.de>, Shawn Evans <shawnwe@hotmail.com>,
       linux-raid@vger.kernel.org, Andre Hedrick <andre@aslab.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Promise FastTrak TX4 losing interrupts (with apic mode)
References: <F14meUdm8TihuWkpKyG0001ebd3@hotmail.com> <20011031162116.AF5A41018@shrek.lisa.de> <Pine.LNX.4.53.0302060313490.9702@ddx.a2000.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>>>    ide7: BM-DMA at 0xb408-0xb40f, BIOS settings: hdo:pio, hdp:pio
>>>hda: WDC WD800BB-00BSA0, ATA DISK drive
>>>hdc: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive
>>>hdi: WDC WD800BB-00BSA0, ATA DISK drive
>>>hdk: WDC WD800BB-00BSA0, ATA DISK drive
>>>hdm: WDC WD800BB-00BSA0, ATA DISK drive
>>>hdo: WDC WD800BB-00BSA0, ATA DISK drive
>>>      
>>>

Don't know if it's related, but I believe these WD drives sometimes stop 
sending interrupts.  WD is aware of the problem and tells me they are 
working on a fix.

    Ross

