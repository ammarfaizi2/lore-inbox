Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265151AbUFAT3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbUFAT3Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 15:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265155AbUFAT3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 15:29:25 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:26601 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S265151AbUFAT3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 15:29:24 -0400
Date: Tue, 1 Jun 2004 21:25:52 +0200 (CEST)
From: Michael De Nil <michael@flex-it.be>
X-X-Sender: flecxie@lisa.flex-it.be
To: linux-kernel@vger.kernel.org
Subject: Promise PDC20378 Raid Accelerator
Message-ID: <Pine.LNX.4.56.0406012040380.6191@lisa.flex-it.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

While googl'ing around on linux-support for the Promise PDC20378 Raid
Accelerator, I found some contrary messages...

- Tyan tells me that Promise only provides closed source modules for the
latest RH & Suse kernels. They also told me that there is no way to use
sata raid under linux when not using standard rh or suse kernel.

- On http://www.busybox.net/pdc-ultra-1.00.0.10.tgz, there seems to be
a free driver by Promise.

- Then, on http://linuxmafia.com/faq/Hardware/sata.html I read:
Promise FastTrak SATA150, SATA150 TX2, SATA150 TX2plus, SATA150 TX4,
SATA150 SX4, SATA378, and Ultra 618 series (e.g., PDC20621, PDC20275,
PDC20618, PDC20318, PDC20319, PDC20375, PDC20378, and PDC20376 chips) ?
the sata_promise driver in Jeff Garzik's libata driver set provides
beta-level support a/o 2004-02-25 (included in kernel 2.6.x). Alleged RAID
is proprietary software RAID: Proprietary drivers from the manufacturer
are available, as are instructions. An now-unmaintained 2003-02 i386
binary driver from the manufacturer (often claimed in error to be open
source; people being fooled by its source-code wrapper) is also available.

- ...


Can someone tell me if I will be able to run 2 SATA discs on a raid1 with
this chip, and if yes, what driver you would prefer? I am a litle bit
afraid for using non-stable drivers... ;)


Thanks

Michael De Nil
