Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318026AbSGPVkr>; Tue, 16 Jul 2002 17:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318040AbSGPVkp>; Tue, 16 Jul 2002 17:40:45 -0400
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:62442 "HELO
	dardhal.mired.net") by vger.kernel.org with SMTP id <S318026AbSGPVkm>;
	Tue, 16 Jul 2002 17:40:42 -0400
Date: Tue, 16 Jul 2002 23:43:32 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel panics on bootup
Message-ID: <20020716214332.GA675@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3D345AD7.1010509@mvpsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D345AD7.1010509@mvpsoft.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 16 July 2002, at 13:41:43 -0400,
Chris Snyder wrote:

> I can't get my Intergraph dual-P133 to boot.  The model number, 
> according to the back of the case, is JHIF60H70.  Here's the error 
> messages that are being displayed:
> 
Something very similar to this happened a couple of days ago to someone
on a IRC Linux channel I often attend...

> SMP motherboard not detected.
> Local APIC not detected.  Using dummy APIC emulation.
>
... and as far as I remember, the person who talked about the problem
said he has solved it by entering the BIOS and activating the local APIC
support. Maybe I am wrong, but I can remember he said that the same
hardware and BIOS configuration worked for him with 2.2.x kernels, but
not with 2.4.x.

But remember, I could veru well be wrong :-)

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Woody (Linux 2.4.19-pre6aa1)
