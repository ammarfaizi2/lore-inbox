Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWEPVlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWEPVlE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWEPVkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:40:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:30382 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932174AbWEPVkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:40:41 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Kumar Gala <galak@kernel.crashing.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 05/10] SPI: Add David as the SPI subsystem maintainer
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 16 May 2006 14:38:33 -0700
Message-Id: <11478155182390-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.3.2
In-Reply-To: <1147815518897-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kumar Gala <galak@kernel.crashing.org>

Add David as the SPI subsystem maintainer

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

025c398710ac24456f0288fc7e64f426c5c5508f
diff --git a/MAINTAINERS b/MAINTAINERS
index 246153d..753584c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2518,6 +2518,12 @@ M:	perex@suse.cz
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
-- 
1.3.2

