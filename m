Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVBHPgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVBHPgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 10:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVBHPgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 10:36:23 -0500
Received: from 66-162-60-3.gen.twtelecom.net ([66.162.60.3]:15264 "EHLO
	lpdsrv13.logicpd.com") by vger.kernel.org with ESMTP
	id S261500AbVBHPgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 10:36:20 -0500
Message-ID: <4208DC72.8010401@visi.com>
Date: Tue, 08 Feb 2005 09:36:18 -0600
From: Jeff Cooper <jacooper@visi.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Disk corruption problem with nVidia motherboard and Silicon Image
  680 ATA controller
References: <3vlXO-27l-9@gated-at.bofh.it> <3vmhl-2kt-33@gated-at.bofh.it>
In-Reply-To: <3vmhl-2kt-33@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Feb 2005 15:36:19.0294 (UTC) FILETIME=[EF4CF7E0:01C50DF3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash Punnoor wrote:
> Jeff Cooper schrieb:
> 
>> I'm running a Gentoo system with a 2.6.10-r6 kernel.  This is the
>> gentoo-dev-sources ebuild.  My motherboard is a Asus A7N8X with an
>> nForce2 nVidia chipset.  The system has five 40 gig hard drives, all set
>>
>>
>> Thanks for any advice anyone can offer!
> 
> 
> Search in bios for ext-p2p discard time and set it to a higher value, at 
> least
> 1ms. I alrealdy reported this to lkml but there apperantly is no 
> interest in
> implementing a kernel quirk.
> 

Well I checkd my BIOS and it doesn't have the ability to adjust that 
option.  There are no new updates for the BIOS of my motherboard or the 
SIIG ATA controllers.

Is this a SATA option?  I only have PATA drives in my system.

Does anyone else have any other suggestions?

thanks,
Jeff
