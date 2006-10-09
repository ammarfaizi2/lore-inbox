Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932681AbWJIMuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbWJIMuP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 08:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbWJIMuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 08:50:14 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:35172 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932652AbWJIMuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 08:50:03 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.19-rc1 10/10] Update the MAINTAINERS file for kmemleak
Date: Mon, 09 Oct 2006 13:49:59 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20061009124959.2695.88905.stgit@localhost.localdomain>
In-Reply-To: <20061009124813.2695.8123.stgit@localhost.localdomain>
References: <20061009124813.2695.8123.stgit@localhost.localdomain>
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
index 17becb9..37841d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1708,6 +1708,12 @@ L:	kernel-janitors@lists.osdl.org
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
