Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWHLWCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWHLWCA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 18:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWHLWBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 18:01:13 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:15776 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964913AbWHLWBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 18:01:09 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.18-rc4 10/10] Update the MAINTAINERS file for kmemleak
Date: Sat, 12 Aug 2006 23:01:04 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060812220104.17709.57807.stgit@localhost.localdomain>
In-Reply-To: <20060812215857.17709.79502.stgit@localhost.localdomain>
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
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
index e3e1515..6dccfbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1663,6 +1663,12 @@ L:	kernel-janitors@lists.osdl.org
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
