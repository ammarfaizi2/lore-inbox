Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262198AbTCTTpx>; Thu, 20 Mar 2003 14:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262204AbTCTTpx>; Thu, 20 Mar 2003 14:45:53 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:55046 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S262198AbTCTTpv>; Thu, 20 Mar 2003 14:45:51 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303201958.h2KJwtIo001730@81-2-122-30.bradfords.org.uk>
Subject: Re: CPU misdetection and, (probably unrelated) IDE data corruption
To: davej@codemonkey.org.uk (Dave Jones)
Date: Thu, 20 Mar 2003 19:58:54 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, vojtech@ucw.cz
In-Reply-To: <20030320190648.GB21382@suse.de> from "Dave Jones" at Mar 20, 2003 07:06:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > * Misdetection of an Athlon 1700XP as a Duron
>  > model name      : AMD Duron(tm) Processor
> 
> This string is set by the BIOS at power-on time.
> If it really is an Athlon, your BIOS is horked.
> Try upgrading it.

The story behind this machine is that I was building it as cheaply as
possible for my parents, (just to browse the web, and write E-Mail).

I never use pre-assembled hardware, prefering to build my boxes from
scratch, but I broke that rule to save money, and recommended that
they bought a pre-assembled case, motherboard, ram and cpu.

To cut a long story short, the board was jumpered for 100 instead of
133, and when re-jumpered at 133, it crashes during init.

It's being returned tomorrow, and from now on, I build systems from
scratch.  Always.

> Out of curiosity, what does x86info[1] make of it ?

x86info v1.12.  Dave Jones 2001-2003
Feedback to <davej@suse.de>.

Found 1 CPU
--------------------------------------------------------------------------
Family: 6 Model: 8 Stepping: 1
CPU Model : Athlon XP (Thoroughbred)[B0]

John.
