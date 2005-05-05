Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVEETox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVEETox (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 15:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVEETnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:43:24 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:34766 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262201AbVEETLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 15:11:45 -0400
Date: Thu, 5 May 2005 14:11:22 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@localhost.localdomain
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 8 of 12] Fix Tpm driver -- Maintainers entry
Message-ID: <Pine.LNX.4.62.0505051338470.5303@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply these fixes to the Tpm driver.  I am resubmitting the entire
patch set that was orginally sent to LKML on April 27 with the changes
that were requested fixed.

This patch was already applied.

Thanks,
Kylie

On Mon, 14 Mar 2005, Randy.Dunlap wrote:
> (Kylene, please add TPM info to MAINTAINERS or CREDITS)

This patch adds the maintainers entry.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com
---
--- linux-2.6.12-rc2/MAINTAINERS	2005-04-04 11:38:36.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/MAINTAINERS	2005-04-14 14:45:57.000000000 -0500
@@ -2116,6 +2116,13 @@ M:	perex@suse.cz
 L:	alsa-devel@alsa-project.org
 S:	Maintained
 
+TPM DEVICE DRIVER
+P:	Kylene Hall
+M:	kjhall@us.ibm.com
+W:	http://tpmdd.sourceforge.net
+L:	tpmdd-devel@lists.sourceforge.net
+S:	Maintained
+
 UltraSPARC (sparc64):
 P:	David S. Miller
 M:	davem@davemloft.net
