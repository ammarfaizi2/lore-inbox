Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbTK2N2E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 08:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbTK2N2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 08:28:04 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:11533 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S263762AbTK2N2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 08:28:02 -0500
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: can't eject CD-ROM
Date: Sat, 29 Nov 2003 14:28:01 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311291428.01107.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have notebook Acer TravelMate 242X with CD-ROM drive

Mitsumi SR244W1

hdc: SR244W1, ATAPI CD/DVD-ROM drive

When I call eject /dev/hdc I gets:

# eject /dev/hdc
eject: unable to eject, last error: Invalid argument

I can eject it by pressing button, but after mount I can work with drive, but 
I can't umount or eject it! and only reboot work to remove CD disk from drive 
by pressing button on drive.

Under WinXP everithing works OK

Thanks for your help

Michal

