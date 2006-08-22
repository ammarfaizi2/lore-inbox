Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWHVUnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWHVUnM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 16:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWHVUnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 16:43:12 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:65506 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S932148AbWHVUnL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 16:43:11 -0400
Date: Tue, 22 Aug 2006 22:40:15 +0200
From: Jules Villard <jvillard@ens-lyon.fr>
To: trivial@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Typo in drivers/usb/gadget/Kconfig
Message-ID: <20060822204015.GB6817@blatterie>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This tiny patch fixes a typo in drivers/usb/gadget/Kconfig. The typo
is present in 2.6.18-rc4 and in the corresponding -mm tree (and AFAIK,
FYI and FWIW was present in previous kernel versions as well).

Regards,

Jules

--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="drivers-usb-gadget-Kconfig-typo.patch"

--- linux-2.6.18-rc4/drivers/usb/gadget/Kconfig	2006-08-22 21:39:53.000000000 +0200
+++ onkr/drivers/usb/gadget/Kconfig	2006-08-22 21:44:23.000000000 +0200
@@ -26,7 +26,7 @@
 	   you need a low level bus controller driver, and some software
 	   talking to it.  Peripheral controllers are often discrete silicon,
 	   or are integrated with the CPU in a microcontroller.  The more
-	   familiar host side controllers have names like like "EHCI", "OHCI",
+	   familiar host side controllers have names like "EHCI", "OHCI",
 	   or "UHCI", and are usually integrated into southbridges on PC
 	   motherboards.
 

--uQr8t48UFsdbeI+V--
