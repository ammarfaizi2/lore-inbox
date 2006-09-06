Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWIFWij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWIFWij (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 18:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWIFWiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 18:38:15 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:43976 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964787AbWIFWiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 18:38:02 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.18-rc6 10/10] Update the MAINTAINERS file for kmemleak
Date: Wed, 06 Sep 2006 23:37:50 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060906223750.21550.65996.stgit@localhost.localdomain>
In-Reply-To: <20060906223536.21550.55411.stgit@localhost.localdomain>
References: <20060906223536.21550.55411.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25cd707..ccb4b97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1669,6 +1669,12 @@ L:	kernel-janitors@lists.osdl.org
 W:	http://www.kerneljanitors.org/
 S:	Maintained
 
+KERNEL MEMORY LEAK DETECTOR
+P:	Catalin Marinas
+M:	catalin.marinas@gmail.com
+W:	http://www.procode.org/
+S:	Maintained
+
 KERNEL NFSD
 P:	Neil Brown
 M:	neilb@cse.unsw.edu.au
