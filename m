Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288285AbSAHUYZ>; Tue, 8 Jan 2002 15:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288287AbSAHUYP>; Tue, 8 Jan 2002 15:24:15 -0500
Received: from marine.sonic.net ([208.201.224.37]:12384 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S288285AbSAHUYF>;
	Tue, 8 Jan 2002 15:24:05 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Tue, 8 Jan 2002 12:23:59 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: "shutdown -r now" (lilo, win98) (fwd)
Message-ID: <20020108202358.GO22948@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0201081952090.7547-100000@Consulate.UFP.CX> <E16O2eJ-0007VZ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16O2eJ-0007VZ-00@the-village.bc.nu>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 08:15:07PM +0000, Alan Cox wrote:
> Some windows driver is assuming things that the BIOS has not cleared up
> on reset and whichit probably shouldn't. Its not uncommon to have to 
> powercycle a box between OS's. Sometimes you see it with windows hanging
> sometimes with Linux

I thought that Linux forced a cold-restart upon a reboot to solve this very
issue.  At least wrt the BIOS.

Perhaps a physical component needs that power cycle to do a reset?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
