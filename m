Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267512AbTBFSUY>; Thu, 6 Feb 2003 13:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267509AbTBFSUX>; Thu, 6 Feb 2003 13:20:23 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:25479 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S267495AbTBFSUW>;
	Thu, 6 Feb 2003 13:20:22 -0500
Date: Thu, 6 Feb 2003 19:30:03 +0100 (CET)
From: Stephan van Hienen <raid@a2000.nu>
To: AU <au@surfer.sbm.temple.edu>
cc: Hans-Peter Jansen <hp@lisa-gmbh.de>, Shawn Evans <shawnwe@hotmail.com>,
       linux-raid@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Promise FastTrak TX4 losing interrupts (with apic mode)
In-Reply-To: <Pine.LNX.4.53.0302061907550.17629@ddx.a2000.nu>
Message-ID: <Pine.LNX.4.53.0302061928520.17629@ddx.a2000.nu>
References: <Pine.SGI.4.32.0302060924010.93623-100000@surfer.sbm.temple.edu>
 <Pine.LNX.4.53.0302061907550.17629@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2003, Stephan van Hienen wrote:

> On Thu, 6 Feb 2003, AU wrote:
>
> > Try to boot with apic=no or acpi=oldboot
> like i do now with append noapic, it works ok

does it 'hurt' running in noapic mode?
or is it only for more irq's available for devices ?
