Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270584AbTGTBRz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 21:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270585AbTGTBRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 21:17:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:49354 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270584AbTGTBRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 21:17:54 -0400
Date: Sun, 20 Jul 2003 03:32:51 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [2.6 patch] remove bouncing digilnux list from MAINTAINERS
Message-ID: <20030720013251.GB14128@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes a bouncing mailing list for an orphaned driver 
from MAINTAINERS.

Please apply
Adrian

--- linux-2.6.0-test1-mm1/MAINTAINERS.old	2003-07-20 03:28:47.000000000 +0200
+++ linux-2.6.0-test1-mm1/MAINTAINERS	2003-07-20 03:29:06.000000000 +0200
@@ -572,9 +572,8 @@
 DIGIBOARD PC/XE AND PC/XI DRIVER
 P:	Christoph Lameter
 M:	christoph@lameter.com
 W:	http://www.digi.com
-L:	digilnux@dgii.com
 S:	Orphaned
 
 DIRECTORY NOTIFICATION
 P:	Stephen Rothwell


