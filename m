Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278673AbRKHWQt>; Thu, 8 Nov 2001 17:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278732AbRKHWQj>; Thu, 8 Nov 2001 17:16:39 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:44042 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S278695AbRKHWQX>; Thu, 8 Nov 2001 17:16:23 -0500
Date: Thu, 8 Nov 2001 17:16:07 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: Wilson <defiler@null.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Any lingering Athlon bugs in Kernel 2.4.14?
In-Reply-To: <001b01c1689f$fdd77850$c800000a@Artifact>
Message-ID: <Pine.LNX.4.10.10111081706491.31943-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Bugs in the Athlon optimizations present in the Linux kernel.

what bugs would those be?  if you're thinking of the infamous
"my athlon dies when I boot a CONFIG_MK7 kernel on a kt133",
it is by all accounts a *chipset* bug, not a kernel bug.
it's still unclear whether the voodoo workaround 
(in both linux and ac) is doing something sensible.

