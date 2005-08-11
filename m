Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVHKRmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVHKRmj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVHKRmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:42:39 -0400
Received: from emulex.emulex.com ([138.239.112.1]:12431 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S932233AbVHKRmi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:42:38 -0400
From: James.Smart@Emulex.Com
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: [PATCH 2.6.13-rc6] Add Emulex as maintainer of lpfc SCSI driver
Date: Thu, 11 Aug 2005 13:42:35 -0400
Message-ID: <9BB4DECD4CFE6D43AA8EA8D768ED51C201AD31@xbl3.ma.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.13-rc6] Add Emulex as maintainer of lpfc SCSI driver
Thread-Index: AcWenA5pkHGdUbL6Q8OGAKUbepIoAw==
To: <linux-kernel@vger.kernel.org>
Cc: <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -upNr a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	2005-08-11 13:10:51.000000000 -0400
+++ b/MAINTAINERS	2005-08-11 13:11:40.000000000 -0400
@@ -824,6 +824,13 @@ L:	emu10k1-devel@lists.sourceforge.net
 W:	http://sourceforge.net/projects/emu10k1/
 S:	Maintained
 
+EMULEX LPFC FC SCSI DRIVER
+P:      James Smart
+M:      james.smart@emulex.com
+L:      linux-scsi@vger.kernel.org
+W:      http://sourceforge.net/projects/lpfcxxxx
+S:      Supported
+
 EPSON 1355 FRAMEBUFFER DRIVER
 P:	Christopher Hoover
 M:	ch@murgatroid.com, ch@hpl.hp.com
