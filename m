Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967959AbWK3XCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967959AbWK3XCR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 18:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967949AbWK3XCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 18:02:10 -0500
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:23500 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S967956AbWK3XCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 18:02:02 -0500
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.19 10/10] Update the MAINTAINERS file for kmemleak
To: linux-kernel@vger.kernel.org
Date: Thu, 30 Nov 2006 23:01:58 +0000
Message-ID: <20061130230157.5469.37895.stgit@localhost.localdomain>
In-Reply-To: <20061130225219.5469.2453.stgit@localhost.localdomain>
References: <20061130225219.5469.2453.stgit@localhost.localdomain>
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
index e182992..995486d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1722,6 +1722,12 @@ L:	kernel-janitors@lists.osdl.org
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
