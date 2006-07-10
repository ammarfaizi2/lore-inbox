Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965258AbWGJWLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965258AbWGJWLg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbWGJWLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:11:19 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:16594 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S965258AbWGJWLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:11:12 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 10/10] Update the MAINTAINERS file for kmemleak
Date: Mon, 10 Jul 2006 23:11:04 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060710221104.5191.40268.stgit@localhost.localdomain>
In-Reply-To: <20060710220901.5191.66488.stgit@localhost.localdomain>
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
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
index 196a31c..808b75e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1635,6 +1635,12 @@ W:	http://www.kerneljanitors.org/
 W:	http://sf.net/projects/kernel-janitor/
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
