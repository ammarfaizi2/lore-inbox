Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267579AbRHKNR3>; Sat, 11 Aug 2001 09:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267602AbRHKNRR>; Sat, 11 Aug 2001 09:17:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20999 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267579AbRHKNRO>; Sat, 11 Aug 2001 09:17:14 -0400
Subject: Re: Kernel lockups on dual-Athlon board -- help wanted
To: esr@thyrsus.com
Date: Sat, 11 Aug 2001 14:19:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20010811062349.A1769@thyrsus.com> from "Eric S. Raymond" at Aug 11, 2001 06:23:49 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15VYfw-0002bu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 6. Here's a weird one.  When the kernel is running, the power switch
>    has to be pressed down for 4 seconds to power down the machine.  But
>    during a lockup it powers down the machine instantly.
> 
> What we're seeing suggests some bad interaction between the SMP
> support and the hardware.  But item 7 hints that power management
> could be involved, even though we have it configured out.

Try a completely different board and components. There are folks running rock 
solid 2.4 on dual Athlons. I speculate yours is perhaps marginal somewhere.

Alan
