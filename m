Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbSLAVJ5>; Sun, 1 Dec 2002 16:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbSLAVJ5>; Sun, 1 Dec 2002 16:09:57 -0500
Received: from barry.mail.mindspring.net ([207.69.200.25]:16155 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S262446AbSLAVJ5>; Sun, 1 Dec 2002 16:09:57 -0500
From: "Kenneth Nealy" <kennealy@sprynet.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Nic card won't activate after 2.4.18-14 kernel recompile
Date: Sun, 1 Dec 2002 16:47:47 -0500
Message-ID: <LBEEKGOMGNBLMHFPDGCBIEILGDAA.kennealy@sprynet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Help,......please :-)!

I recompiled my Redhat Linux 8, 2.4.18-14, kernel on a system containing a
Kingston Etherx KNE100TX PCI Fast Ethernet adapter. After recompiling the
kernel I created a separate kernel configuration called
2.4.18-14custom11-28-02 and used Grub to boot, either to the original
installed kernel configuration or to the new 2.4.18-14custom11-28-02 kernel
configuration. If I boot to the original kernel configuration the nic card
activates. But if I boot to the 2.4.18-14custom11-28-02 kernel configuration
the nic card won't activate. I used the 'ifconfig -a' command which shows
the nic card as eth0 & up. I used the 'lspci' command which shows the nic
card using the proper resources.

Please help,....ever since they allowed me to use Linux in this
asylum,....I've been bouncing around in the same spot in my rubber room.
This extremely agitates the hired help,...which have to watch,...they prefer
randomness.

Oh,...I long for the days when that beautiful woman would say that tender
word,.....'CLEAR',...before she sent 460 volts through me. After she blacked
out the upper east side,....those powers that be made her switch to drugs.

As I look into her eyes, through the door, I notice,... she's really pissed
off,.....


