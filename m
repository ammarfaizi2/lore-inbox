Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267602AbTACRjZ>; Fri, 3 Jan 2003 12:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267603AbTACRjY>; Fri, 3 Jan 2003 12:39:24 -0500
Received: from relais.videotron.ca ([24.201.245.36]:30158 "EHLO
	VL-MS-MR001.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S267602AbTACRjJ>; Fri, 3 Jan 2003 12:39:09 -0500
Date: Fri, 03 Jan 2003 12:47:41 -0500
From: 0_o Genius o_0 <cybergenius@iquebec.com>
Subject: PROBLEM: nForce USB Bug!
To: linux-kernel@vger.kernel.org
Message-id: <001f01c2b350$37064ab0$0200a8c0@jsrlepage>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. What is the problem : My computer hangs at the loading of USB modules.

2. Description :
My computer hangs precisely when the kernel tries to configure (himself?)
USB devices. I have a Lexmark X75 printern and a Cordless Trackman Wheel
mouse by Logitech. When one of them - or the two - are connected, the kernel
just stops. No kernel panic. When they are disconnected, the kernel works
like a charm.

3. Keywords : None.

4. Kernel version : 2.4.18-14 (from redhat), 2.4.19-16mdk (from mandrake),
2.4.20 (a beautiful home-compiled kernel).

5. Oops? no oops here...

6. Small shell : i can't make one because i don't know how, but also
because... i dont think it would be shellable.

7. Environment
Well since i reverted to windows after that, i'll describe my comp :
Software : Mandrake, RedHat or Slackware alike, it hangs.
Processor Info : AMD AthlonXP 1800+ ±1533 mhz
Module info : ?, but i think its is hub.c or usb.c that hangs.
Loaded driver info : it's approximately the first driver that loads...
PCI info : on windows, how?
SCSI : i don't have any
Other relevant info : i have the nForce 415D-based ASUS A7N266-C, with audi
but without network card and graphics adapter integrated. maybe THIS is the
bug? I'll point out that i have 4 usb plugs.

