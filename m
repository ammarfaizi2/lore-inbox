Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288088AbSACAze>; Wed, 2 Jan 2002 19:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288098AbSACAz3>; Wed, 2 Jan 2002 19:55:29 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:22020
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S288088AbSACAxz>; Wed, 2 Jan 2002 19:53:55 -0500
Subject: Re: Strange USB issues... - 2.4.x Kernels & more info
From: Shawn Starr <spstarr@sh0n.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16LwFY-0006Ja-00@the-village.bc.nu>
In-Reply-To: <E16LwFY-0006Ja-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 02 Jan 2002 19:55:40 -0500
Message-Id: <1010019369.20264.19.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any fix for this or just have to live with the crappy USB port ;-)

Shawn.

On Wed, 2002-01-02 at 20:00, Alan Cox wrote:
> > If I turn on USB and boot to a Linux kernel WITH NO USB support compiled
> > in. I get:
> > 
> > 1) Slow loading of kernel into memory on bootup
> > 2) AT keyboard timeout (?) errors and no activity with the keyboard
> > (shift lock/numlock/scroll lock). I  have to reboot to correct the
> > problem by disabling USB in the bios.
> 
> Buggy BIOS SMM emulation of PS/2 keyboard and mouse on the USB port.
> 


