Return-Path: <linux-kernel-owner+w=401wt.eu-S1161088AbWLPPt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbWLPPt0 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 10:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbWLPPsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 10:48:10 -0500
Received: from queue01-winn.ispmail.ntl.com ([81.103.221.55]:5281 "EHLO
	queue01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161084AbWLPPrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 10:47:39 -0500
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.20-rc1 10/10] Update the MAINTAINERS file for kmemleak
To: linux-kernel@vger.kernel.org
Date: Sat, 16 Dec 2006 15:36:04 +0000
Message-ID: <20061216153604.18200.81631.stgit@localhost.localdomain>
In-Reply-To: <20061216153346.18200.51408.stgit@localhost.localdomain>
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dea5b2a..fe186b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1746,6 +1746,12 @@ L:	kernel-janitors@lists.osdl.org
 W:	http://www.kerneljanitors.org/
 S:	Maintained
 
+KERNEL MEMORY LEAK DETECTOR
+P:	Catalin Marinas
+M:	catalin.marinas@gmail.com
+W:	http://www.procode.org/kmemleak/
+S:	Maintained
+
 KERNEL NFSD
 P:	Neil Brown
 M:	neilb@cse.unsw.edu.au
