Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbRCMV52>; Tue, 13 Mar 2001 16:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131194AbRCMVcC>; Tue, 13 Mar 2001 16:32:02 -0500
Received: from zeus.kernel.org ([209.10.41.242]:7373 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131196AbRCMVbL>;
	Tue, 13 Mar 2001 16:31:11 -0500
Message-ID: <3AAE8840.86EA48C1@adelphia.net>
Date: Tue, 13 Mar 2001 15:51:12 -0500
From: Stephen Wille Padnos <stephenwp@adelphia.net>
X-Mailer: Mozilla 4.76C-SGI [en] (X11; U; IRIX64 6.5 IP28)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Toscano <pete.lkml@toscano.org>
CC: Greg KH <greg@wirex.com>, linux-kernel@vger.kernel.org
Subject: Re: APIC  usb MPS 1.4 and the 2.4.2 kernel
In-Reply-To: <200103130245.f2D2j2J01057@janus.local.degeorge.org> <20010313002513.A1664@bubba.toscano.org> <20010313092837.A805@wirex.com> <20010313124954.B5626@bubba.toscano.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Toscano wrote:
> 
> Very interesting.  I had not heard about this.  Are there any SMP boards
> with a VIA chipset that does work well with Linux and USB?  I have an
> old P2B-DS that I had replace with this board as I needed more PCI
> slots.  Heck, for that matter are there any SMP boards that work well
> with Linux and USB that have six or more PCI slots?
> 

Well, I use an old SuperMicro ( http://www.supermicro.com ) P6DNH
board.  It has 8 PCI slots, 3 ISA slots, an I960 I2O processor (four of
the PCI slots are on a secondary bus), and supports dual Pentium Pro
CPUs and 1G RAM (EDO - it's 4 years old).

They have newer boards with 6 PCI (64 bit, 66 MHz) + 1 AGP slot.  Their
boards are very high quality - though you'll pay for the reliability in
$$$.


-- 
Stephen Wille Padnos
Programmer, Engineer, Problem Solver
swpadnos@adelphia.net
