Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbTAEBPo>; Sat, 4 Jan 2003 20:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbTAEBPn>; Sat, 4 Jan 2003 20:15:43 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:48281 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262380AbTAEBPc>; Sat, 4 Jan 2003 20:15:32 -0500
Message-ID: <3E17836F.2000303@enib.fr>
Date: Sun, 05 Jan 2003 01:59:27 +0100
From: XI <xizard@enib.fr>
Organization: http://www.chez.com/xizard
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Molina <tmolina@copper.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: sound is stutter, sizzle with lasts kernel releases
References: <Pine.LNX.4.44.0212031636140.1170-100000@lap.molina>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina wrote:
> On Mon, 2 Dec 2002, PlasmaJohn wrote:
> 
> 
>>Please excuse me if I'm being naive, but aren't SBlive cards really bad bus
>>citizens and have problems on SMP machines, Via chipsets, etc.?
>>
>>Or did Linux fix what Creative and Microsoft couldn't.  Or won't.  ;)
> 
> 
> SBline doesn't share interrupts well.  Usually, changing PCI slots in 
> order to affect what interrupt is used can help a lot.  The problem is, 
> depending on the motherboard, figuring out what a particular PCI slot 
> shares an interrupt with can be difficult.
> 
> -

Hi,

After some time, I have tested ALL possibilities with my PCI graphic 
card and my sound blaster live. (4 PCI slots => 12 possibilities).

The problem is always the same, sound still stutter.


Sum-up of my problem:
The sound of my computer stutter when I move a window, watch a movie, 
... with a kernel 2.4.19 and 2.4.20 ; whereas with a kernel 2.4.8, it 
works fine.
I use a sound blaster live! with a Matrox G200 PCI, and an AMD 760MPX 
chipset.

What has changed since kernel 2.4.8 which could cause this problem?


Regards,
				Xavier

