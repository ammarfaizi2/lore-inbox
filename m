Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBUIbL>; Wed, 21 Feb 2001 03:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129592AbRBUIbC>; Wed, 21 Feb 2001 03:31:02 -0500
Received: from [138.6.98.137] ([138.6.98.137]:46600 "EHLO
	caspian.prebus.uppsala.se") by vger.kernel.org with ESMTP
	id <S129051AbRBUIaz>; Wed, 21 Feb 2001 03:30:55 -0500
Message-ID: <E44E649C7AA1D311B16D0008C73304460933A9@caspian.prebus.uppsala.se>
From: Per Erik Stendahl <PerErik@onedial.se>
To: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Unmounting and ejecting the root fs on shutdown.
Date: Wed, 21 Feb 2001 09:27:22 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm putting together a maintenance/rescue CD. It's bootable with
RH6.2 (2.2.16) "installed" - ie the root fs is on the CD itself, no
harddrives involved. I've run across a slight inconvenience:
when I shutdown the CD is still locked in the drive. I have to power-off
then power-on again to get the CD out of the drive. Is there any way
I can get the kernel to unlock the CD and even possibly eject it
on shutdown? If kernel-hacking is required could somebody please
point to where it should be done? (I'm not very familiar with the
kernel-layout).

TIA,
Per Erik Stendahl
