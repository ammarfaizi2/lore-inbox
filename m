Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbULNSFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbULNSFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 13:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbULNSEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 13:04:12 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:11672 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261603AbULNSCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 13:02:49 -0500
Date: Tue, 14 Dec 2004 19:02:47 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel thoughts of a Linux user
Message-ID: <Pine.LNX.4.61.0412141856480.13661@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>So they could make themselves a favor and run something like seti@home.
>>>
>>>That does consume more energy than just sitting at idle.  I've seen some
>>>estimates of how much it costs to run seti 24/7 rather than just sit idle, 
>>>and the price was something like $80/year.
>>
>> For CPUs which don't have some sort of speedstep, it does not matter.
>> (Please correct me if I am wrong. It might be that HLT cycles are still 
>> more power-conservative even without speedstep than 24/7 on the FPU.)
>
>You're wrong :)
>Nowadays the power consumption of a CPU is more than the rest of the
>machine altogether (including hard disks, etc.).
>
>On my P4 2.8GHz HT CPU, I've measured the power consumed by *the entire
>computer* more than doubling as the processor went from idle into 100%
>load.
>
>Of course, this doesn't include a monster 3D card, is it could very well
>consume something close to the processor when doing a lot of 3D operations.

I have got a power measure device from university and experimented myself.
I keep it short: running SETI (in constrast to nothing, i.e. HLT insns),
only costs me 17 more Watts. With a price of 6 cent per kWh, this makes 
roughly 5.54 EUR per year when the machine is on 16h/340days.

(The theoretical case of 24/365 would make up 8.91 EUR.)

Wait, did not Intel pull back some processors because of their enormous heat 
of some P4 (which melted some)? Well, I guess *there* is all your $$ going.


Jan Engelhardt
-- 
ENOSPC
