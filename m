Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279994AbRKDQcg>; Sun, 4 Nov 2001 11:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279996AbRKDQc1>; Sun, 4 Nov 2001 11:32:27 -0500
Received: from nic-131-c196-222.mw.mediaone.net ([24.131.196.222]:64776 "EHLO
	moonweaver.awesomeplay.com") by vger.kernel.org with ESMTP
	id <S279994AbRKDQcM>; Sun, 4 Nov 2001 11:32:12 -0500
Subject: Via Reboot and Keyboard
From: Sean Middleditch <elanthis@awesomeplay.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100 (Preview Release)
Date: 04 Nov 2001 11:36:43 -0500
Message-Id: <1004891803.470.9.camel@stargrazer>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again all,

 On my laptop's VIA82C686 bios, if I reboot with Linux, the machine
doesn't boot up properly.  It gives me a keyboard error, among other
things.  This happens with kernel 2.4.7, 2.4.12, and 2.4.13 (which, btw,
now seems to work fine, tho I haven't tested it much - I think there may
have been something in the -ac branch that was making it die before).

 However, on 2.4.9, it works fine.  I reboot, and the computer comes
back up OK.  Same if I rebooted from WindowsXP.

 How the frick can I debug this one?

Sean Etc.



