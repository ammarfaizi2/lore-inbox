Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWF2Rmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWF2Rmn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 13:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWF2Rmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 13:42:43 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:54030 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751100AbWF2Rmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 13:42:42 -0400
Date: Thu, 29 Jun 2006 13:42:21 -0400
From: Matt LaPlante <laplam@rpi.edu>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Documentation/IPMI typos
Message-Id: <20060629134221.9460671e.laplam@rpi.edu>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 13:42:31 -0400
	(not processed: message from trusted or authenticated source)
X-Return-Path: laplam@rpi.edu
X-Envelope-From: laplam@rpi.edu
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 13:42:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two typos in Documentation/IPMI...  Alan, if you could just verify the first please.

-- 
Matt LaPlante
CCNP, CCDP, A+, Linux+, CQS
laplam@rpi.edu

-

--- b/Documentation/IPMI.txt	2006-06-29 01:36:01.000000000 -0400
+++ a/Documentation/IPMI.txt	2006-06-29 01:40:21.000000000 -0400
@@ -10,7 +10,7 @@
 It provides for dynamic discovery of sensors in the system and the
 ability to monitor the sensors and be informed when the sensor's
 values change or go outside certain boundaries.  It also has a
-standardized database for field-replacable units (FRUs) and a watchdog
+standardized database for field-replaceable units (FRUs) and a watchdog
 timer.
 
 To use this, you need an interface to an IPMI controller in your
@@ -64,7 +64,7 @@
 IPMI defines a standard watchdog timer.  You can enable this with the
 'IPMI Watchdog Timer' config option.  If you compile the driver into
 the kernel, then via a kernel command-line option you can have the
-watchdog timer start as soon as it intitializes.  It also have a lot
+watchdog timer start as soon as it initializes.  It also have a lot
 of other options, see the 'Watchdog' section below for more details.
 Note that you can also have the watchdog continue to run if it is
 closed (by default it is disabled on close).  Go into the 'Watchdog

