Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWADWCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWADWCh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWADWCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:02:36 -0500
Received: from fmr17.intel.com ([134.134.136.16]:44977 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932145AbWADWCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:02:21 -0500
Message-ID: <43BC45DE.5060303@intel.com>
Date: Wed, 04 Jan 2006 14:02:06 -0800
From: "John L. Villalovos" <john.l.villalovos@intel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: trivial@rustcorp.com.au, torvalds@osdl.org
Subject: [PATCH] MAINTAINERS file: Fix missing colon
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: John L. Villalovos <john.l.villalovos@intel.com>

While parsing the MAINTAINERS file I disovered one entry was missing a colon. 
This patch adds the one missing colon.

---
diff -r 8441517e7e79 MAINTAINERS
--- a/MAINTAINERS       Thu Jan  5 04:00:05 2006
+++ b/MAINTAINERS       Wed Jan  4 13:49:27 2006
@@ -681,7 +681,7 @@

  DAC960 RAID CONTROLLER DRIVER
  P:     Dave Olien
-M      dmo@osdl.org
+M:     dmo@osdl.org
  W:     http://www.osdl.org/archive/dmo/DAC960
  L:     linux-kernel@vger.kernel.org
  S:     Maintained



Signed-off-by: John L. Villalovos <john.l.villalovos@intel.com>
