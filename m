Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129244AbRBCX3V>; Sat, 3 Feb 2001 18:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129275AbRBCX3L>; Sat, 3 Feb 2001 18:29:11 -0500
Received: from idefix.linkvest.com ([194.209.53.99]:45066 "EHLO
	idefix.linkvest.com") by vger.kernel.org with ESMTP
	id <S129244AbRBCX3D>; Sat, 3 Feb 2001 18:29:03 -0500
Message-ID: <B45465FD9C23D21193E90000F8D0F3DF6838FD@mailsrv.linkvest.ch>
From: Jean-Eric Cuendet <Jean-Eric.Cuendet@linkvest.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-raid@vger.rutgers.edu'" <linux-raid@vger.rutgers.edu>
Subject: RAID autodetect and 2.4.1
Date: Sun, 4 Feb 2001 00:28:30 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I have a server with RAID1 partitions with linux 2.4.1 (stock,
self-compiled) installed.
It was easy to create the RAID partitions but when booting, no
auto-detection is successful.
The kernel says that autodetect is running, then done, but nothing is
auto-detected.
My devices are IDE devices (hda + hdc) and all drivers are bult-ins (no
initrd nor modules).
After the boot, making a raidstart works like a charm...
Any advice?
Help welcomed.

Thanks
-jec

PS: I'm not in the list, so CC me please.

_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
Jean-Eric Cuendet
Linkvest SA
Av des Baumettes 19, 1020 Renens Switzerland
Tel +41 21 632 9043  Fax +41 21 632 9090
http://www.linkvest.com  E-mail: jean-eric.cuendet@linkvest.com
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
