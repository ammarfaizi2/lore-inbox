Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUDNXTu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUDNWcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:32:02 -0400
Received: from mail.kroah.org ([65.200.24.183]:48543 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261982AbUDNWZK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:25:10 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <10819814501036@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:10 -0700
Message-Id: <1081981450639@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.12, 2004/04/02 11:02:14-08:00, mochel@digitalimplant.org

[PATCH] I2C: Add ALi 1563 Device ID to pci_ids.h


 include/linux/pci_ids.h |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Wed Apr 14 15:14:00 2004
+++ b/include/linux/pci_ids.h	Wed Apr 14 15:14:00 2004
@@ -994,6 +994,7 @@
 #define PCI_DEVICE_ID_AL_M1531		0x1531
 #define PCI_DEVICE_ID_AL_M1533		0x1533
 #define PCI_DEVICE_ID_AL_M1541		0x1541
+#define PCI_DEVICE_ID_AL_M1563		0x1563
 #define PCI_DEVICE_ID_AL_M1621		0x1621
 #define PCI_DEVICE_ID_AL_M1631		0x1631
 #define PCI_DEVICE_ID_AL_M1632		0x1632

