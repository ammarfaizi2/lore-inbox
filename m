Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWAMKIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWAMKIF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWAMKIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:08:05 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:7610 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S964831AbWAMKIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:08:04 -0500
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 12/13] USBATM: bump version numbers
Date: Fri, 13 Jan 2006 11:08:05 +0100
User-Agent: KMail/1.9.1
Cc: usbatm@lists.infradead.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200601121729.52596.baldrick@free.fr>
In-Reply-To: <200601121729.52596.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Gw3xDio9AJj+K8l"
Message-Id: <200601131108.06255.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Gw3xDio9AJj+K8l
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Duncan Sands <baldrick@free.fr>

--Boundary-00=_Gw3xDio9AJj+K8l
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="12-version"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="12-version"

Index: Linux/drivers/usb/atm/speedtch.c
===================================================================
--- Linux.orig/drivers/usb/atm/speedtch.c	2006-01-13 09:23:12.000000000 +0100
+++ Linux/drivers/usb/atm/speedtch.c	2006-01-13 09:27:55.000000000 +0100
@@ -42,7 +42,7 @@
 #include "usbatm.h"
 
 #define DRIVER_AUTHOR	"Johan Verrept, Duncan Sands <duncan.sands@free.fr>"
-#define DRIVER_VERSION	"1.9"
+#define DRIVER_VERSION	"1.10"
 #define DRIVER_DESC	"Alcatel SpeedTouch USB driver version " DRIVER_VERSION
 
 static const char speedtch_driver_name[] = "speedtch";
Index: Linux/drivers/usb/atm/usbatm.c
===================================================================
--- Linux.orig/drivers/usb/atm/usbatm.c	2006-01-13 09:25:43.000000000 +0100
+++ Linux/drivers/usb/atm/usbatm.c	2006-01-13 09:27:55.000000000 +0100
@@ -92,7 +92,7 @@
 #endif
 
 #define DRIVER_AUTHOR	"Johan Verrept, Duncan Sands <duncan.sands@free.fr>"
-#define DRIVER_VERSION	"1.9"
+#define DRIVER_VERSION	"1.10"
 #define DRIVER_DESC	"Generic USB ATM/DSL I/O, version " DRIVER_VERSION
 
 static const char usbatm_driver_name[] = "usbatm";

--Boundary-00=_Gw3xDio9AJj+K8l--
