Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131201AbRACApx>; Tue, 2 Jan 2001 19:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131801AbRACApn>; Tue, 2 Jan 2001 19:45:43 -0500
Received: from jalon.able.es ([212.97.163.2]:62136 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131201AbRACApc>;
	Tue, 2 Jan 2001 19:45:32 -0500
Date: Wed, 3 Jan 2001 01:14:54 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: "Giacomo A . Catenazzi" <cate@dplanet.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Coppermine is a PIII or a Celeron? WINCHIP2/WINCHIP3D diff?
Message-ID: <20010103011454.C1229@werewolf.able.es>
In-Reply-To: <3A523012.CF78B83D@dplanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A523012.CF78B83D@dplanet.ch>; from cate@dplanet.ch on Tue, Jan 02, 2001 at 20:46:26 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.02 Giacomo A. Catenazzi wrote:
> Hello!
> 
> When working in cpu autoconfiguration I found some problems:
> 
> I have to identify this processor:
>   Vendor: Intel
>   Family: 6
>   Model:  8
> Is it a "Pentium III (Coppermine)" (setup.c:1709)
> or a "Celeron (Coppermine)" (setup.c:1650) ?
> 

AFAIK, both. Coppermine is the code name of the low level arch of
the chip.

Really, the kernel should be querying the builder: Have you a
Deschutes, a Mendocino or a Coppermine ? How much cache do you have ?
But that is rarely known (Uh? I bought a Pentium III). You have to 
guess from the answer to:
Have you a PII, an old Celeron (Mendocino) or a new Cel-PIII (Copper).

-- 
J.A. Magallon                                         $> cd pub
mailto:jamagallon@able.es                             $> more beer

Linux werewolf 2.2.19-pre3-aa3 #3 SMP Wed Dec 27 10:25:32 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
