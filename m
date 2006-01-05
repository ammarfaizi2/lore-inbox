Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWAEXYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWAEXYL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWAEXYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:24:10 -0500
Received: from pin.if.uz.zgora.pl ([212.109.128.251]:33019 "EHLO
	pin.if.uz.zgora.pl") by vger.kernel.org with ESMTP id S1750815AbWAEXYJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:24:09 -0500
Message-ID: <43BDAC1F.7080107@pin.if.uz.zgora.pl>
Date: Fri, 06 Jan 2006 00:30:39 +0100
From: Jacek Luczak <difrost@pin.if.uz.zgora.pl>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.6.15
References: <43BDA76F.1000906@pin.if.uz.zgora.pl> <9a8748490601051512w72ea0baekd52d991d2984c017@mail.gmail.com>
In-Reply-To: <9a8748490601051512w72ea0baekd52d991d2984c017@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl napisał(a):
> On 1/6/06, Jacek Luczak <difrost@pin.if.uz.zgora.pl> wrote:
> 
>>HI all
>>
>>I receive this Oops (see below) with kernels from 2.6.15-rc5 to 2.6.15
>>(I haven't using earlier versions of 2.6.15-rc). I'm using sk98lin
>>driver (version 8.28.1.3) from Syskonnect and ndiswrapper-1.7. Is this
>>error caused by sk98lin driver?
>>
> 
> It might be.
> As long as you are running a tainted kernel, getting people to look
> seriously at an oops is going to be hard - no way to debug the
> binary-only code that tainted the kernel, so it's pretty impossible to
> know what's going on.
> 
> [snip]
> 
>>Jan  5 19:25:04 slawek kernel: Modules linked in: sk98lin ndiswrapper
>>usbhid uhci_hcd i915
>>Jan  5 19:25:04 slawek kernel: CPU:    0
>>Jan  5 19:25:04 slawek kernel: EIP:    0060:[<c0138603>]    Tainted: P
> 
> 
> Try and reproduce with a non-tainted kernel.

I will try and send more info.

Big Thank
	J. L.

