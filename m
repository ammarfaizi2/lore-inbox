Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbUKSM2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbUKSM2u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 07:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbUKSMFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 07:05:10 -0500
Received: from [195.23.16.24] ([195.23.16.24]:1439 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261367AbUKSMDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 07:03:11 -0500
Message-ID: <419DE0F3.9000806@grupopie.com>
Date: Fri, 19 Nov 2004 12:02:59 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Tomas Carnecky <tom@dbservice.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel thoughts of a Linux user
References: <200411181859.27722.gjwucherpfennig@gmx.net> <419CFF73.3010407@dbservice.com> <Pine.LNX.4.53.0411182146060.29376@yvahk01.tjqt.qr> <419D10DF.4040902@nortelnetworks.com> <Pine.LNX.4.53.0411182216160.16465@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411182216160.16465@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.18; VDF: 6.28.0.80; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>So they could make themselves a favor and run something like seti@home.
>>
>>That does consume more energy than just sitting at idle.  I've seen some
>>estimates of how much it costs to run seti 24/7 rather than just sit idle, and
>>the price was something like $80/year.
> 
> 
> For CPUs which don't have some sort of speedstep, it does not matter.
> (Please correct me if I am wrong. It might be that HLT cycles are still more
> power-conservative even without speedstep than 24/7 on the FPU.)

You're wrong :)

Nowadays the power consumption of a CPU is more than the rest of the 
machine altogether (including hard disks, etc.).

On my P4 2.8GHz HT CPU, I've measured the power consumed by *the entire 
computer* more than doubling as the processor went from idle into 100% 
load.

Of course, this doesn't include a monster 3D card, is it could very well 
consume something close to the processor when doing a lot of 3D operations.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
