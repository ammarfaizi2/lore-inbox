Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbTI0VvK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 17:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbTI0VvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 17:51:10 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27080 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262213AbTI0VvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 17:51:08 -0400
Date: Sat, 27 Sep 2003 23:51:00 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] USB_SERIAL_KEYSPAN_USA49WLC Configure.help entry
Message-ID: <20030927215100.GD15338@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

the trivial patch below adds a Configure.help entry for 
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC.

Please apply
Adrian

--- linux-2.4.23-pre5-full/Documentation/Configure.help.old	2003-09-27 23:46:52.000000000 +0200
+++ linux-2.4.23-pre5-full/Documentation/Configure.help	2003-09-27 23:47:52.000000000 +0200
@@ -15088,6 +15088,9 @@
 CONFIG_USB_SERIAL_KEYSPAN_USA49W
   Say Y here to include firmware for the USA-49W converter.
 
+CONFIG_USB_SERIAL_KEYSPAN_USA49WLC
+  Say Y here to include firmware for the USA-49WLC converter.
+
 USB ZyXEL omni.net LCD Plus Driver
 CONFIG_USB_SERIAL_OMNINET
   Say Y here if you want to use a ZyXEL omni.net LCD ISDN TA.
