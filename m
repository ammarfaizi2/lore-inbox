Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284746AbRLJX6y>; Mon, 10 Dec 2001 18:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284754AbRLJX6o>; Mon, 10 Dec 2001 18:58:44 -0500
Received: from net128-053.mclink.it ([195.110.128.53]:4078 "EHLO
	mail.mclink.it") by vger.kernel.org with ESMTP id <S284752AbRLJX6c>;
	Mon, 10 Dec 2001 18:58:32 -0500
Message-ID: <3C154C27.2030202@arpacoop.it>
Date: Tue, 11 Dec 2001 00:58:31 +0100
From: Carl Scarfoglio <scarfoglio@arpacoop.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.1-pre8: lockups whem mounting scsi cdrom
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HW: MB Asus A7V, 256MB Ram, Athlon 800 MHz,four HD attache to standard
ATA and ATA-100 Promise controller, 1 Realtek 8029 ethernet adapter,
Adaptec 2904 (AIC 7850), 1 scsi CD-writer (Waitec. i.e. Philips 2200 or
so), Teac scsi CD-ROM, 1 Mustek A3 plugged to external scsi connector.
The Adaptec has Irq 11 exclusilively.
SW: SuSE 6.3 with some changes, gcc 2.9.3.

I am running 2.5.1-pre8. I cannot mount data CD. When I execute the
mount command, on any drive, a hard lockup follows. No messages from the
mount command, no noise from the drives.
The PC hangs solid: keyboard and mouse are dead, no telnet access, when
in X the session is dead. I must flip the power switch.

But I can write CD's with cdrecord and play audio CD's!!

Kernel 2.5.0 does not have this problem.

TIA

Carlo Scarfoglio

