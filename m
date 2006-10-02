Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWJBLAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWJBLAo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 07:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWJBLAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 07:00:44 -0400
Received: from symlink.to.noone.org ([85.10.207.172]:44504 "EHLO sym.noone.org")
	by vger.kernel.org with ESMTP id S1750786AbWJBLAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 07:00:43 -0400
Date: Mon, 2 Oct 2006 13:00:41 +0200
From: Tobias Klauser <tklauser@distanz.ch>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove duplicate entry for stable branch from MAINTAINERS
Message-ID: <20061002110041.GA12231@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Editor: Vi IMproved 6.3
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was introduced by commit 4ca8a3c1b17cde8241eb9157484519427fa5bf91

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

---
 MAINTAINERS |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f0cd5a3..b62ab43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2711,14 +2711,6 @@ M:	chrisw@sous-sol.org
 L:	stable@kernel.org
 S:	Maintained
 
-STABLE BRANCH:
-P:	Greg Kroah-Hartman
-M:	greg@kroah.com
-P:	Chris Wright
-M:	chrisw@sous-sol.org
-L:	stable@kernel.org
-S:	Maintained
-
 TPM DEVICE DRIVER
 P:	Kylene Hall
 M:	kjhall@us.ibm.com
-- 
1.4.2

