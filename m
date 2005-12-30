Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbVL3ROM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbVL3ROM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 12:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbVL3ROM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 12:14:12 -0500
Received: from [202.67.154.148] ([202.67.154.148]:31376 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S964876AbVL3ROL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 12:14:11 -0500
Message-ID: <43B56ADD.7040300@ns666.com>
Date: Fri, 30 Dec 2005 18:14:05 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Mozilla/4.8 [en] (Windows NT 5.1; U)
X-Accept-Language: en-us
MIME-Version: 1.0
To: Folkert van Heusden <folkert@vanheusden.com>
CC: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
References: <43B53EAB.3070800@ns666.com>	<9a8748490512300627w26569c06ndd4af05a8d6d73b6@mail.gmail.com>	<43B557D7.6090005@ns666.com> <43B5623D.7080402@ns666.com> <20051230164751.GQ3105@vanheusden.com>
In-Reply-To: <20051230164751.GQ3105@vanheusden.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden wrote:
> 
>>>I'm not sure what to make of this, but it looks like only 1 cpu is kept
>>>busy with interrupts:
>>>           CPU0       CPU1       CPU2       CPU3
>>>  0:    1033372          0          0          0    IO-APIC-edge  timer
> 
> 
> Install the 'irqbalance' package.
> 
> 


<..>

Thanks ! I installed it now, it asked me something about a "one shot
mode" but i chose no. Correct me if i should choose the other mode.
Should i reboot for this to take effect ? Cause i still see the 0's
under the other cpu's.

Appreciate the help !
