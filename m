Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbRHKKqs>; Sat, 11 Aug 2001 06:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266251AbRHKKqi>; Sat, 11 Aug 2001 06:46:38 -0400
Received: from tahallah.demon.co.uk ([158.152.175.193]:47628 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S265844AbRHKKqa>; Sat, 11 Aug 2001 06:46:30 -0400
Date: Sat, 11 Aug 2001 11:46:14 +0100 (BST)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel lockups on dual-Athlon board -- help wanted
In-Reply-To: <20010811062349.A1769@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0108111145530.4433-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2001, Eric S. Raymond wrote:

> 6. Here's a weird one.  When the kernel is running, the power switch
>    has to be pressed down for 4 seconds to power down the machine.  But
>    during a lockup it powers down the machine instantly.
>
> What we're seeing suggests some bad interaction between the SMP
> support and the hardware.  But item 7 hints that power management
> could be involved, even though we have it configured out.

You appear to be missing item 7.

-- 
Sigfault: Witty message dumped.

http://www.tahallah.demon.co.uk

