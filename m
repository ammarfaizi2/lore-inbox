Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136238AbREJUNg>; Thu, 10 May 2001 16:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136197AbREJUNV>; Thu, 10 May 2001 16:13:21 -0400
Received: from sanrafael.dti2.net ([195.57.112.5]:6417 "EHLO dti2.net")
	by vger.kernel.org with ESMTP id <S136114AbREJUM4>;
	Thu, 10 May 2001 16:12:56 -0400
Message-ID: <012301c0d98d$a190ee60$061010ac@dti2.net>
From: "Jorge Boncompte [DTI2]" <jorge@dti2.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.2 - Locked keyboard
Date: Thu, 10 May 2001 22:13:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all!

    I have a squid server box (~150 users) that has been running without
problems since 2.4.0-test10. Now with 2.4.2 it has had an uptime of 29 days
(power loss). After the reboot, the keyboard was working 5 minutes and then
it locked. The console was working. I rebooted the machine again and has
been working for 2 days, that the keyboard gets locked again.

    I changed the keyboard and looked at the keyboard plugs unsucessfully.

    Could this be related to a kernel bug or an userspace issue??? How can I
debug it?

    -Jorge

MB Tyan K7 - K7 800Mhz
Kernel 2.4.2 - Compiled for Athlon/K7 (no problems)
Modules: via-rhine - sundance - osst - ide-scsi scsi-mod - ip_tables -
iptable_mangle - ip_conntrack - iptable_nat - ipt_MARK - ipt_REDIRECT
Debian Woody
gcc 2.95.2
Libc 2.2.2
==============================================================
Jorge Boncompte - Técnico de sistemas
DTI2 - Desarrollo de la Tecnología de las Comunicaciones
--------------------------------------------------------------
C/ Abogado Enriquez Barrios, 5   14004 CORDOBA (SPAIN)
Tlf: +34 957 761395 / FAX: +34 957 450380
--------------------------------------------------------------
jorge@dti2.net _-_-_-_-_-_-_-_-_-_-_-_-_-_ http://www.dti2.net
==============================================================
- Sin pistachos no hay Rock & Roll...
- Without wicker a basket cannot be done.
==============================================================


