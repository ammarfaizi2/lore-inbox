Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262863AbVAFPCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbVAFPCS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbVAFPCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:02:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18439 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262863AbVAFPA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:00:26 -0500
Date: Thu, 6 Jan 2005 16:00:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [patch] 2.6.10-mm2: remove umsdos MAINTAINERS entry
Message-ID: <20050106150022.GB3096@stusta.de>
References: <20050106002240.00ac4611.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With umsdos gone, there's no longer a MAINTAINERS entry required.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/MAINTAINERS.old	2005-01-06 15:51:57.000000000 +0100
+++ linux-2.6.10-mm2-full/MAINTAINERS	2005-01-06 15:52:18.000000000 +0100
@@ -2266,13 +2266,6 @@
 W:	http://linux-udf.sourceforge.net
 S:	Maintained
 
-UMSDOS FILESYSTEM
-P:	Matija Nalis
-M:	Matija Nalis <mnalis-umsdos@voyager.hr>
-L:	linux-kernel@vger.kernel.org
-W:	http://linux.voyager.hr/umsdos/
-S:	Maintained
-
 UNIFORM CDROM DRIVER
 P:	Jens Axboe
 M:	axboe@suse.de

