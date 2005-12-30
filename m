Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbVL3VPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbVL3VPi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 16:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbVL3VPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 16:15:38 -0500
Received: from [202.67.154.148] ([202.67.154.148]:36000 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S1750770AbVL3VPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 16:15:37 -0500
Message-ID: <43B5A371.4050905@ns666.com>
Date: Fri, 30 Dec 2005 22:15:29 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Mozilla/4.8 [en] (Windows NT 5.1; U)
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark v Wolher <trilight@ns666.com>
CC: Folkert van Heusden <folkert@vanheusden.com>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
References: <43B53EAB.3070800@ns666.com>	<9a8748490512300627w26569c06ndd4af05a8d6d73b6@mail.gmail.com>	<43B557D7.6090005@ns666.com> <43B5623D.7080402@ns666.com>	<20051230164751.GQ3105@vanheusden.com> <43B56ADD.7040300@ns666.com>	<20051230183021.GV3105@vanheusden.com> <43B5890E.30104@ns666.com> <20051230202429.GD11594@vanheusden.com> <43B59F88.1030704@ns666.com>
In-Reply-To: <43B59F88.1030704@ns666.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark v Wolher wrote:
> Folkert van Heusden wrote:
> 
>>>Hmm, i disabled MSI in the kernel, irq-balancing is on in the kernel,
>>>and after a restart with irqbalance i see the cpu's show numbers !
>>>I guess MSI was preventing them ? But does that means because of MSI
>>>that performance was lower in some way ?
>>
>>
>>did you also restart with only irqbalance activated?
>>
>>
>>Folkert van Heusden
>>
> 
> 
> Yes, when MSI was disabled i had irq-balancing in the kernel on, i
> rebooted without the irqbalance daemon and it showed no reaction on the
> cpu's. When i enabled the irqbalance daemon then i got finally reaction
> from the cpu's.
> 
> I'm also curious if this will solve those random freezes...which somehow
> i suspect have to do with the tvcard and maybe having MSI on.
> 

:( just got a total freeze, number 2 today. This time i noticed the
mouse started to go very slow and 2 seconds later all was frozen.

Maybe it's because of vmware ... i will not use vmware and see how it goes.
