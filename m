Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267535AbTBFXFq>; Thu, 6 Feb 2003 18:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267539AbTBFXFp>; Thu, 6 Feb 2003 18:05:45 -0500
Received: from air-2.osdl.org ([65.172.181.6]:24711 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267535AbTBFXFo>;
	Thu, 6 Feb 2003 18:05:44 -0500
Date: Thu, 6 Feb 2003 15:15:22 -0800
From: Dave Olien <dmo@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Subject: [PATCH] Add DAC960 to MAINTAINERs list
Message-ID: <20030206231522.GA3875@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add me as maintainer for DAC960 driver.

--------------------------------------------------------------------------------

diff -ur linux-2.5.59_original/MAINTAINERS linux-2.5.59_Maintainers/MAINTAINERS
--- linux-2.5.59_original/MAINTAINERS	2003-01-16 18:22:18.000000000 -0800
+++ linux-2.5.59_Maintainers/MAINTAINERS	2003-02-06 15:07:57.000000000 -0800
@@ -460,6 +460,13 @@
 W:	http://www.cyclades.com/
 S:	Supported
 
+DAC960 RAID CONTROLLER DRIVER
+P:	Dave Olien
+M	dmo@osdl.org
+W:	http://www.osdl.org/archive/dmo/DAC960
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+
 DAMA SLAVE for AX.25
 P:	Joerg Reuter
 M:	jreuter@yaina.de
