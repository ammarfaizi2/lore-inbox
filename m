Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264004AbSLMNjT>; Fri, 13 Dec 2002 08:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264622AbSLMNjS>; Fri, 13 Dec 2002 08:39:18 -0500
Received: from [213.196.40.44] ([213.196.40.44]:25491 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id <S264004AbSLMNjG>;
	Fri, 13 Dec 2002 08:39:06 -0500
Date: Fri, 13 Dec 2002 13:53:06 +0100 (CET)
From: Bas Vermeulen <bvermeul@blackstar.nl>
To: Take Vos <Take.Vos@binary-magic.com>
cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: PS/2 keyboard and mouse not available/working/weird
In-Reply-To: <200212122036.18595.Take.Vos@binary-magic.com>
Message-ID: <Pine.LNX.4.33.0212131351230.8757-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2002, Take Vos wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Tuesday 22 October 2002 16:34, Vojtech Pavlik wrote:
> > On Tue, Oct 22, 2002 at 04:03:49PM +0200, Take Vos wrote:
> > > In 2.5.44 both my PS/2 mice are not available, neither is my keyboard,
> > > although after sufficient keystrokes, sometimes 5, sometimes more, the
> > > keyboard is found, this is with Xfree.
> I am now using 2.5.51 and I still have the problem when I reboot from a 2.5.51 
> kernel to a 2.5.51 or 2.4.19 kernel both my internal keyboard and mouse (DELL 
> Inspiron 8100) are not working anymore. The strange thing is the keyboard 
> does work in grub.
> 
> relevant dmesg output:
> 	device class 'input': registering
> 	register interface 'mouse' with class 'input'
> 	mice: PS/2 mouse device common for all mice
> 	register interface 'joystick' with class 'input'
> 	register interface 'event' with class 'input'
> 	input: PS/2 Synaptics TouchPad on isa0060/serio1
> 	serio: i8042 AUX port at 0x60,0x64 irq 12
> 	input: AT Set 2 keyboard on isa0060/serio0
> 	serio: i8042 KBD port at 0x60,0x64 irq 1

I have exactly the same problem on an Inspiron 8000. Been that way since 
2.5.4x (7 or 8), but cannot get a working 2.5.51 to test at this point.

Just to add another data point. :)

Bas Vermeulen

-- 
"God, root, what is difference?" 
	-- Pitr, User Friendly

"God is more forgiving." 
	-- Dave Aronson

