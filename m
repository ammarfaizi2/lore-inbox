Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUCPOms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbUCPOmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:42:39 -0500
Received: from styx.suse.cz ([82.208.2.94]:59777 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261914AbUCPOTg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:36 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <1079446776714@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 12/44] Credit to Panagiotis Issaris for Graphire 3 support
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:36 +0100
In-Reply-To: <10794467761075@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1474.188.12, 2004-01-26 18:35:00+01:00, panagiotis.issaris@mech.kuleuven.ac.be
  input: Credit to Panagiotis Issaris for Graphire 3 support.


 wacom.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/usb/input/wacom.c b/drivers/usb/input/wacom.c
--- a/drivers/usb/input/wacom.c	Tue Mar 16 13:19:36 2004
+++ b/drivers/usb/input/wacom.c	Tue Mar 16 13:19:36 2004
@@ -1,7 +1,7 @@
 /*
  *  USB Wacom Graphire and Wacom Intuos tablet support
  *
- *  Copyright (c) 2000-2002 Vojtech Pavlik	<vojtech@ucw.cz>
+ *  Copyright (c) 2000-2004 Vojtech Pavlik	<vojtech@ucw.cz>
  *  Copyright (c) 2000 Andreas Bach Aaen	<abach@stofanet.dk>
  *  Copyright (c) 2000 Clifford Wolf		<clifford@clifford.at>
  *  Copyright (c) 2000 Sam Mosel		<sam.mosel@computer.org>
@@ -9,6 +9,7 @@
  *  Copyright (c) 2000 Daniel Egger		<egger@suse.de>
  *  Copyright (c) 2001 Frederic Lepied		<flepied@mandrakesoft.com>
  *  Copyright (c) 2002 Ping Cheng		<pingc@wacom.com>
+ *  Copyright (c) 2004 Panagiotis Issaris	<panagiotis.issaris@mech.kuleuven.ac.be>
  *
  *  ChangeLog:
  *      v0.1 (vp)  - Initial release
@@ -48,6 +49,7 @@
  *	v1.30 (vp) - Merge 2.4 and 2.5 drivers
  *		   - Since 2.5 now has input_sync(), remove MSC_SERIAL abuse
  *		   - Cleanups here and there
+ *    v1.30.1 (pi) - Added Graphire3 support
  */
 
 /*

