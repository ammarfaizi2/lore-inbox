Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288052AbSACAcg>; Wed, 2 Jan 2002 19:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288067AbSACAbQ>; Wed, 2 Jan 2002 19:31:16 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:19716
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S288038AbSACAaQ>; Wed, 2 Jan 2002 19:30:16 -0500
Subject: Strange USB issues...
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 02 Jan 2002 19:32:02 -0500
Message-Id: <1010017950.20263.7.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Pentium 200Mhz AMD Bios (home machine):

USB 1.0 - 2 ports

The bios has 2 options:

Enable USB controller and enable USB legacy stuff. 

If I turn on USB and boot to a Linux kernel WITH NO USB support compiled
in. I get:

1) Slow loading of kernel into memory on bootup
2) AT keyboard timeout (?) errors and no activity with the keyboard
(shift lock/numlock/scroll lock). I  have to reboot to correct the
problem by disabling USB in the bios.

I'm not sure why this is happening, if anyone else has been noticing
this please let me know or would like me to do some debugging :-)

Shawn.



