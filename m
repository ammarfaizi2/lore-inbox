Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132542AbRA2KCy>; Mon, 29 Jan 2001 05:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132974AbRA2KCo>; Mon, 29 Jan 2001 05:02:44 -0500
Received: from tartu.cyber.ee ([193.40.16.128]:22803 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id <S132542AbRA2KCf>;
	Mon, 29 Jan 2001 05:02:35 -0500
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.1-pre11
In-Reply-To: <Pine.LNX.4.10.10101281020540.3850-100000@penguin.transmeta.com>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.4.0-ac4 (i586))
Message-Id: <E14NB8r-000063-00@roos.tartu-labor>
Date: Mon, 29 Jan 2001 12:02:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LT> I just uploaded it to kernel.org, and I expect that I'll do the final
LT> 2.4.1 tomorrow, before leaving for NY and LinuxWorld. Please test that the
LT> pre-kernel works for you..
[...]
LT> pre10:
[...]
LT>  - Andy Grover: APCI update

I tried test11 yesterday. Works fine except when I enable ACPI instead of
APM. Never tried this before but now I decided to give it a try.
After initialising ACPI, the machine became slow as a 386 or a 286.

AMD Duron 600, Soltek 75KV mobo w/VIA KT133 chipset, UP-APIC kernel, IDE-only
system.

-- 
Meelis Roos (mroos@linux.ee)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
