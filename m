Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLMWq0>; Wed, 13 Dec 2000 17:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129543AbQLMWqQ>; Wed, 13 Dec 2000 17:46:16 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:38672 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S129391AbQLMWqE>; Wed, 13 Dec 2000 17:46:04 -0500
Message-Id: <200012132215.eBDMFas35908@aslan.scsiguy.com>
To: linux-kernel@vger.kernel.org
Subject: Adaptec AIC7XXX v 6.0.6 BETA Released
Date: Wed, 13 Dec 2000 15:15:36 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

daptec SCSI HBA device driver for the Linux Operating System
To: linux-scsi@vger.kernel.org
cc:
Fcc: +outbox
Subject: Adaptec AIC7XXX v6.0.6 BETA Released
-------
After several months of testing and refinement, the Adaptec 
sponsored aic7xxx driver is now entering Beta testing.  Although
still missing domain validation and the last bits of cardbus
support, there are no known issues with the driver.  I would
encourage all users of card supported by this driver to try the
new code and submit feedback.  Patches for late 2.2.X, 2.3.99
and 2.4.0 are provided in the driver distribution.  For those
of you building the driver as a module, take note that the module
name is now "aic7xxx_mod" rather than "aic7xxx".

As always, the most recent distribution is available here:

http://people.FreeBSD.org/~gibbs/linux/

--
Justin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
