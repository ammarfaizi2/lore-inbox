Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267650AbTBEBIL>; Tue, 4 Feb 2003 20:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267651AbTBEBIL>; Tue, 4 Feb 2003 20:08:11 -0500
Received: from zok.sgi.com ([204.94.215.101]:6283 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S267650AbTBEBIK>;
	Tue, 4 Feb 2003 20:08:10 -0500
Date: Tue, 4 Feb 2003 17:17:43 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: MAINTAINERS update for SN support
Message-ID: <20030205011743.GA26333@sgi.com>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick add to the maintainers file for SN (aka Altix 3000) support in
the kernel.

Thanks,
Jesse


--- linux-2.5.59/MAINTAINERS	Thu Jan 16 18:22:18 2003
+++ linux-2.5.59-ia64/MAINTAINERS	Mon Feb  3 14:37:59 2003
@@ -797,6 +797,13 @@
 W:	http://www.linuxia64.org/
 S:	Maintained
 
+SN-IA64 (Itanium) SUB-PLATFORM
+P:	Jesse Barnes
+M:	jbarnes@sgi.com
+L:	linux-ia64@linuxia64.org
+W:	http://www.sgi.com/altix
+S:	Maintained
+
 IBM MCA SCSI SUBSYSTEM DRIVER
 P:	Michael Lang
 M:	langa2@kph.uni-mainz.de
