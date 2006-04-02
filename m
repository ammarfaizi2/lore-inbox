Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWDBVHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWDBVHW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 17:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWDBVHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 17:07:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:38635 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932364AbWDBVHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 17:07:22 -0400
Date: Sun, 2 Apr 2006 16:05:54 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: david-b@pacbell.net
cc: linux-kernel@vger.kernel.org, <spi-devel-general@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] SPI: Add David as the SPI subsystem maintainer
Message-ID: <Pine.LNX.4.44.0604021605160.9478-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add David as the SPI subsystem maintainer

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit f72dafdc5b74d45213ad3f007db07d77c9905880
tree 9a040949b0c394dde5be5fd165f7a891280d89ee
parent 5d4fe2c1ce83c3e967ccc1ba3d580c1a5603a866
author Kumar Gala <galak@kernel.crashing.org> Thu, 30 Mar 2006 23:53:23 -0600
committer Kumar Gala <galak@kernel.crashing.org> Thu, 30 Mar 2006 23:53:23 -0600

 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c946581..d004ce9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2486,6 +2486,12 @@ M:	perex@suse.cz
 L:	alsa-devel@alsa-project.org
 S:	Maintained
 
+SPI SUBSYSTEM
+P:	David Brownell
+M:	dbrownell@users.sourceforge.net
+L:	spi-devel-general@lists.sourceforge.net
+S:	Maintained
+
 TPM DEVICE DRIVER
 P:	Kylene Hall
 M:	kjhall@us.ibm.com

