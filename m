Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbVCBR4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVCBR4D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 12:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVCBRyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 12:54:09 -0500
Received: from alog0429.analogic.com ([208.224.222.205]:15536 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262382AbVCBRt4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 12:49:56 -0500
Date: Wed, 2 Mar 2005 12:48:25 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Lee Revell <rlrevell@joe-job.com>, Ben Greear <greearb@candelatech.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network speed Linux-2.6.10 
In-Reply-To: <200503021740.j22HedCX006731@laptop11.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.61.0503021245060.5955@chaos.analogic.com>
References: <200503021740.j22HedCX006731@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005, Horst von Brand wrote:

> Lee Revell <rlrevell@joe-job.com> said:
>> On Tue, 2005-03-01 at 12:20 -0800, Ben Greear wrote:
>
> [...]
>
>>> What happens if you just don't muck with the NIC and let it auto-negotiate
>>> on it's own?
>
>> This can be asking for trouble too (auto negotiation is often buggy).
>
> I'be seen much more broken networks than buggy autonegotiation. If they
> negotiate something funny, check and fix the network.
> --

In this case it's going to negotiate with the exact same device
in the other box when connected with a X-over cable, and with
a Netgear switch on my desk when not. In both cases, I have
complete control of the "network".

FYI I just upgraded to Linux-2.6.11 I'm going to repeat my
experiment(s) later today after I put the same kernel on
my other machine.

> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
