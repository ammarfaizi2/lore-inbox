Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbRALW1k>; Fri, 12 Jan 2001 17:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132461AbRALW1a>; Fri, 12 Jan 2001 17:27:30 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:28151 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S129595AbRALW1N>; Fri, 12 Jan 2001 17:27:13 -0500
Date: Fri, 12 Jan 2001 14:27:07 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: "V.P." <vpedro@individual.EUnet.pt>
cc: linux-kernel@vger.kernel.org
Subject: Re: APIC ERRor on CPU0: 00(02) ...
In-Reply-To: <3A5F172D.8C77E17@individual.EUnet.pt>
Message-ID: <Pine.LNX.4.21.0101121425350.18375-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is due to your piece of trash motherboard. The reason that the older
kernel didn't catch these errors is because (IIRC) it wasn't looking for
them; they were there even then. The BP6 is a low-end mainboard and was
engineered very poorly; these errors are due to that fact alone.

Talk to you later,

-Kelsey

On Fri, 12 Jan 2001, V.P. wrote:

> I have a Motherboard BP6 with two Celeron 500 (Not overclocked) and
> Linux Kernel-2.4
> 
> and I have de message
> 
> APIC error on CPU0: 00(02)
> APIC error on CPU1: 00(08)
> APIC error on CPU1: 08(04)
> APIC error on CPU0: 02(08)
> APIC error on CPU0: 08(08)
> APIC error on CPU1: 04(04)
> APIC error on CPU0: 08(02)
> APIC error on CPU1: 04(02)
> 
> 
> What wrongs ?
> 
>  This message doesn 't  appears in Kernel-2.2.17 only in Kernel-2.4
> 
>   Any Help is apreciated
> 
> 
>   V.P.                 ***  Linux **  Porto *** Portugal
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-- 
 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
