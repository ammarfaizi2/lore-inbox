Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVIDX3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVIDX3z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVIDX3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:29:55 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:22913 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932101AbVIDX3y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:29:54 -0400
Message-Id: <20050904232316.186793000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:00 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-update-email-address-ph.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 01/54] email address update
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update email address of Peter Hettkamp.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/bt8xx/bt878.c       |    2 +-
 drivers/media/dvb/bt8xx/bt878.h       |    2 +-
 drivers/media/dvb/bt8xx/dvb-bt8xx.h   |    2 +-
 drivers/media/dvb/frontends/cx24110.c |    2 +-
 drivers/media/dvb/frontends/cx24110.h |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/bt8xx/bt878.c	2005-09-04 22:24:25.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/bt8xx/bt878.c	2005-09-04 22:27:47.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  * bt878.c: part of the driver for the Pinnacle PCTV Sat DVB PCI card
  *
- * Copyright (C) 2002 Peter Hettkamp <peter.hettkamp@t-online.de>
+ * Copyright (C) 2002 Peter Hettkamp <peter.hettkamp@htp-tel.de>
  *
  * large parts based on the bttv driver
  * Copyright (C) 1996,97,98 Ralph  Metzler (rjkm@metzlerbros.de)
--- linux-2.6.13-git4.orig/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2005-09-04 22:24:25.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2005-09-04 22:27:47.000000000 +0200
@@ -2,7 +2,7 @@
  * Bt8xx based DVB adapter driver
  *
  * Copyright (C) 2002,2003 Florian Schirmer <jolt@tuxbox.org>
- * Copyright (C) 2002 Peter Hettkamp <peter.hettkamp@t-online.de>
+ * Copyright (C) 2002 Peter Hettkamp <peter.hettkamp@htp-tel.de>
  * Copyright (C) 1999-2001 Ralph  Metzler & Marcus Metzler for convergence integrated media GmbH
  * Copyright (C) 1998,1999 Christian Theiss <mistert@rz.fh-augsburg.de>
  *
--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/cx24110.c	2005-09-04 22:24:25.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/cx24110.c	2005-09-04 22:27:47.000000000 +0200
@@ -1,7 +1,7 @@
 /*
     cx24110 - Single Chip Satellite Channel Receiver driver module
 
-    Copyright (C) 2002 Peter Hettkamp <peter.hettkamp@t-online.de> based on
+    Copyright (C) 2002 Peter Hettkamp <peter.hettkamp@htp-tel.de> based on
     work
     Copyright (C) 1999 Convergence Integrated Media GmbH <ralph@convergence.de>
 
--- linux-2.6.13-git4.orig/drivers/media/dvb/frontends/cx24110.h	2005-09-04 22:24:25.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/frontends/cx24110.h	2005-09-04 22:27:47.000000000 +0200
@@ -1,7 +1,7 @@
 /*
     cx24110 - Single Chip Satellite Channel Receiver driver module
 
-    Copyright (C) 2002 Peter Hettkamp <peter.hettkamp@t-online.de> based on
+    Copyright (C) 2002 Peter Hettkamp <peter.hettkamp@htp-tel.de> based on
     work
     Copyright (C) 1999 Convergence Integrated Media GmbH <ralph@convergence.de>
 
--- linux-2.6.13-git4.orig/drivers/media/dvb/bt8xx/bt878.h	2005-09-04 22:24:25.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/bt8xx/bt878.h	2005-09-04 22:27:47.000000000 +0200
@@ -1,7 +1,7 @@
 /*
     bt878.h - Bt878 audio module (register offsets)
 
-    Copyright (C) 2002 Peter Hettkamp <peter.hettkamp@t-online.de>
+    Copyright (C) 2002 Peter Hettkamp <peter.hettkamp@htp-tel.de>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by

--

