Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130321AbQJ1QSs>; Sat, 28 Oct 2000 12:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130278AbQJ1QSj>; Sat, 28 Oct 2000 12:18:39 -0400
Received: from gw.intermec.com ([204.57.247.22]:7416 "EHLO gw.intermec.com")
	by vger.kernel.org with ESMTP id <S129327AbQJ1QS2>;
	Sat, 28 Oct 2000 12:18:28 -0400
Message-ID: <E36790918FA6D411856500508BD3B2CA1A42@eusegotmail1b.eu.intermec.com>
From: Daniel.Deimert@intermec.com
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com
Subject: PROBLEM: DELL PERC/Megaraid RAID driver in Linux 2.2.18pre17 hang
	s on boot
Date: Sat, 28 Oct 2000 09:15:53 -0700
Importance: high
X-Priority: 1
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LINUX KERNEL PROBLEM REPORT

[1.] Megaraid driver in Linux 2.2.18pre17 hangs on boot

[2.] Full description of the problem:

The Megaraid driver in Linux 2.2.18pre17 (labelling itself as "1.11") hangs
completely
on loading/boot on a DELL 6300, after detecting the DELL PERC adapter
("Found a...")

[3.] Keywords: dell, ami, megaraid, raid, scsi, driver

[4.] Kernel version: 2.2.18pre17

[5.] N/A

[6.] N/A

[7] Environment:

Red Hat 6.2
DELL PERC Megaraid firmware U.84 Firmware 1.63
DELL 6300

[X.]  Other notes:

Megaraid Driver 1.09 from earlier kernels works on this system with
2.2.18pre17.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
