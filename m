Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758531AbWK0SxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758531AbWK0SxV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758534AbWK0SxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:53:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:2961 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1758531AbWK0SxU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:53:20 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,464,1157353200"; 
   d="scan'208"; a="166979524:sNHT289888193"
From: Jason Gaston <jason.d.gaston@intel.com>
To: khali@linux-fr.org, linux-kernel@vger.kernel.org, gregkh@suse.de,
       jason.d.gaston@intel.com, i2c@lm-sensors.org
Subject: [PATCH 2.6.19-rc6] i2c-i801: Documentation patch for Intel ICH9/ICH8/ESB2
Date: Mon, 27 Nov 2006 10:53:11 -0800
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611271053.11904.jason.d.gaston@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the Intel ICH9/ICH8/ESB2 SMBus Controller text to i2c-i801 documentation.

Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>

--- linux-2.6.19-rc6/Documentation/i2c/busses/i2c-i801.orig	2006-11-27 10:36:37.000000000 -0800
+++ linux-2.6.19-rc6/Documentation/i2c/busses/i2c-i801	2006-11-27 10:43:02.000000000 -0800
@@ -9,7 +9,10 @@
   * Intel 82801EB/ER (ICH5) (HW PEC supported, 32 byte buffer not supported)
   * Intel 6300ESB
   * Intel 82801FB/FR/FW/FRW (ICH6)
-  * Intel ICH7
+  * Intel 82801G (ICH7)
+  * Intel 631xESB/632xESB (ESB2)
+  * Intel 82801H (ICH8)
+  * Intel ICH9
     Datasheets: Publicly available at the Intel website
 
 Authors: 
