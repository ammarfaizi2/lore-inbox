Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274757AbRKCWbs>; Sat, 3 Nov 2001 17:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274809AbRKCWbi>; Sat, 3 Nov 2001 17:31:38 -0500
Received: from nposte03.axime.com ([160.92.113.38]:53953 "EHLO
	mail.laposte.net") by vger.kernel.org with ESMTP id <S274757AbRKCWbc>;
	Sat, 3 Nov 2001 17:31:32 -0500
Subject: Problem with ECS k7s5a and ATI Radeon
From: Laurent Mouillart <laurent.mouillart@laposte.net>
To: Linux Kernel Mailling List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100 (Preview Release)
Date: 03 Nov 2001 23:31:25 +0100
Message-Id: <1004826686.1810.13.camel@athena>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When exiting an X window session normally all looks good.
When I switching to a virtual console <ctl><alt><Fn> all looks good too.
But when killing it with <ctl><alt><bkspc> (every time berfore the
window are completly loaded, somtimes when window manager are completly
loaded)system reboot.


I used an ECS k7s5a with radeon 64vivo under recently updated debian sid
+ Linux-2.4.13-ac7.
When i enable in BIOS:
ACPI
PowerManagement
PNP OS

System print "hda irq lose" and hang.



