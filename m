Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286916AbRL1O2a>; Fri, 28 Dec 2001 09:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286914AbRL1O2T>; Fri, 28 Dec 2001 09:28:19 -0500
Received: from mail.nep.net ([12.23.44.24]:57106 "HELO nep.net")
	by vger.kernel.org with SMTP id <S286919AbRL1O2J>;
	Fri, 28 Dec 2001 09:28:09 -0500
Message-ID: <19AB8F9FA07FB0409732402B4817D75A1251C1@FILESERVER.SRF.srfarms.com>
From: "Ryan C. Bonham" <Ryan@srfarms.com>
To: "Linux Kernel List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Tyan Tomcat i815T(S2080) LAN problems
Date: Fri, 28 Dec 2001 09:35:45 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Has anyone gotten the Dual built-in LAN cards to work on the Tyan S2080 Motherboard?  I am running a Redhat kernel 2.4.9-13.. I haven't tried the latest kernel yet.. I saw some talk about this board in the archives but I found no solutions. It says it has a Intel 82559 LAN controller and a ICH2 LAN Controller. I am only seeing one NIC when I boot up. And dmesg is showing
eth0: Invalid EEPROM checksum 0xFF00, check setting before activating this device!

eth0 does initialize, and I can ping from it.  Anyways, is this fixed in a later kernel or is there a patch out there that hasn't made it into the kernel yet??

Thanks

Ryan Bonham
