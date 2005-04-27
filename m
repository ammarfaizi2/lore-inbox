Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVD0WWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVD0WWj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 18:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVD0WU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 18:20:57 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:38083 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262063AbVD0WTA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:19:00 -0400
Date: Wed, 27 Apr 2005 17:18:46 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 8 of 12] Fix Tpm driver -- Maintainers entry
In-Reply-To: <20050314145522.787a6865.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.61.0504271638180.3929@jo.austin.ibm.com>
References: <20050314145522.787a6865.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
