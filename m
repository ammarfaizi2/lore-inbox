Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264938AbUEQIpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264938AbUEQIpY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 04:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264940AbUEQIpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 04:45:24 -0400
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:14466 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S264938AbUEQIpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 04:45:15 -0400
Message-ID: <40A87BA8.8020508@uni-paderborn.de>
Date: Mon, 17 May 2004 10:45:28 +0200
From: Alexander Bruder <anib@uni-paderborn.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan De Luyck <lkml@kcore.org>
CC: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [2.6.6] Synaptics driver is 'jumpy'
References: <200405161222.48581.lkml@kcore.org> <200405170832.32256.lkml@kcore.org> <200405170142.41289.dtor_core@ameritech.net> <200405170904.24471.lkml@kcore.org>
In-Reply-To: <200405170904.24471.lkml@kcore.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-UNI-PB_FAK-EIM-MailScanner-Information: Please see http://imap.uni-paderborn.de for details
X-UNI-PB_FAK-EIM-MailScanner: Found to be clean
X-UNI-PB_FAK-EIM-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-5, required 4, AUTH_EIM_USER -5.00)
X-MailScanner-From: anib@uni-paderborn.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok. Passing on to acpi-devel@lists.sourceforge.net.
> 
> I've looked in the archives, and the problem looks very much like the one in 
> this thread:
> 
> http://sourceforge.net/mailarchive/forum.php?thread_id=4172848&forum_id=6102
> 
> And I've been noticing some keyboard glitches too, but these were to 
> unfrequent, and usually occur only in one application (gaim) so I figured it 
> might be a bug in gaim... guess not...

I can confirm the problem not only in gaim but also on the console and 
other applications with 2.6.6 .

> Unfortunately, the hints in this thread don't help. I've browsed the input 
> system FAQ, but no dice.
> 
> The only thing that gives me a working synaptics touchpad is acpi=off.

Same for me (Acer TravelMate LciB 801).

> It worked fine with 2.6.5.
> 
> Jan
> 

Alexander
