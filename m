Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbTKJKZV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 05:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbTKJKZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 05:25:21 -0500
Received: from [62.67.222.139] ([62.67.222.139]:39064 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S263125AbTKJKZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 05:25:18 -0500
Date: Mon, 10 Nov 2003 11:24:44 +0100
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel@vger.kernel.org
Subject: Weird partititon recocnising problem in 2.6.0-testX
Message-ID: <20031110102444.GA8552@synertronixx3>
Reply-To: konsti@ludenkalle.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: http://www.ludenkalle.de/konsti/pubkey.asc
User-Agent: Mutt/1.5.4i
X-Spam-Score: 3.3
X-Spam-Report: Spam detection software, running on the system "kermit", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	admin@mail.ku-gbr.de for details.
	Content preview:  We have a new boot log at
	http://ludenkalle.de/ide_change_kernel.txt With
	CONFIG_BLK_DEV_IDEDISK=y but unset CONFIG_BLK_DEV_HD_IDE and the
	inserted (and no used) printk stuff. [...] 
	Content analysis details:   (3.3 points, 10.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 RCVD_IN_NJABL_DIALUP   RBL: NJABL: dialup sender did non-local SMTP
	[217.81.46.38 listed in dnsbl.njabl.org]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[Dynamic/Residential IP range listed by]
	[easynet.nl DynaBlock - <http://dynablock.easynet.nl/errors.html>]
	0.1 RCVD_IN_NJABL          RBL: Received via a relay in dnsbl.njabl.org
	[217.81.46.38 listed in dnsbl.njabl.org]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[217.81.46.38 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a new boot log at

http://ludenkalle.de/ide_change_kernel.txt

With CONFIG_BLK_DEV_IDEDISK=y but unset CONFIG_BLK_DEV_HD_IDE and the
inserted (and no used) printk stuff.

Regards, Konsti

-- 
2.6.0-test8-love3
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 1:01, 13 users
