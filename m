Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbTGZTEC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 15:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267724AbTGZTEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 15:04:01 -0400
Received: from [65.244.37.61] ([65.244.37.61]:61604 "EHLO
	WSPNYCON1IPC.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S267705AbTGZTD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 15:03:59 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A920234CD65@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: "'jcwren@jcwren.com'" <jcwren@jcwren.com>,
       Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org
Subject: RE: Does sysfs really provides persistent hardware path to device
	s?
Date: Sat, 26 Jul 2003 15:18:43 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: J.C. Wren [mailto:jcwren@jcwren.com]
> Sent: Saturday, July 26, 2003 12:59 PM
> 
> 	Specifically using your example of USB memories, I have 
> seen devices move 
> around just because of rebooting.  I have a Sandisk SDDR-31 
> (MMC) and a 
> SDDR-33 (CF) that remain plugged into the same USB ports all 
> the time.  

I also have an SDDR-31.  My best experiences with it have been,
well, horrible.  But the same is true of that device under
WinBlows 2000 or XP.

Last time I used it was 2.5.6x something (I patched the bios
on the device that uses flash to allow me to load a new linux
image to the flash in situ.)  I guess I'll try again.
