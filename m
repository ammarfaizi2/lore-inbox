Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVCZRWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVCZRWa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 12:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVCZRW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 12:22:29 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:8971
	"HELO linuxace.com") by vger.kernel.org with SMTP id S261200AbVCZRWY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 12:22:24 -0500
Date: Sat, 26 Mar 2005 09:22:22 -0800
From: Phil Oester <kernel@linuxace.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>, Luca <kronos@kronoz.cjb.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Garbage on serial console after serial driver loads
Message-ID: <20050326172222.GB6121@linuxace.com>
References: <20050325202414.GA9929@dreamland.darkstar.lan> <20050325203853.C12715@flint.arm.linux.org.uk> <20050325210132.GA11201@dreamland.darkstar.lan> <Pine.LNX.4.61.0503261115480.28431@yvahk01.tjqt.qr> <20050326151005.D12809@flint.arm.linux.org.uk> <20050326155549.GA5881@linuxace.com> <20050326163729.A23306@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050326163729.A23306@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 04:37:29PM +0000, Russell King wrote:
> > serio: i8042 AUX port at 0x60,0x64 irq 12
> > serio: i8042 KBD port at 0x60,0x64 irq 1
> > Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled

Garbage here

Sorry -- I was relying upon my (flawed) memory of the bootup sequence,
but sending you the contents from /var/log/dmesg.  

Phil
