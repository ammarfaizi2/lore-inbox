Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbUKCXKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbUKCXKh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbUKCXKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:10:07 -0500
Received: from spectre.fbab.net ([212.214.165.139]:40617 "HELO mail2.fbab.net")
	by vger.kernel.org with SMTP id S261976AbUKCXD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:03:29 -0500
Message-ID: <418963BD.5030303@fbab.net>
Date: Thu, 04 Nov 2004 00:03:25 +0100
From: "Magnus Naeslund(t)" <mag@fbab.net>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
References: <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu>
In-Reply-To: <20041103105840.GA3992@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -V0.7.1 Real-Time Preemption patch, which can be
> downloaded from:
> 
>     http://redhat.com/~mingo/realtime-preempt/
> 
> this release is mainly a merge of -V0.6.9 to 2.6.10-rc2-mm2.
> 
[snip]

I just wanted to tell you that my network problems with the e100 driver 
disappeared. I still get the BUG in enable_irq, but now the network 
works. I dunno if this is due to 2.6.10-rc2-mm2 fixes or your own fixes, 
but i'm now happy :)

I'm going to try this patch on a network game server, that's pretty 
latency demanding.

Regards,
Magnus

