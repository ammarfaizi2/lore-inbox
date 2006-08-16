Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWHPMLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWHPMLB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWHPMLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:11:00 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:57139 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751140AbWHPMLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:11:00 -0400
Date: Wed, 16 Aug 2006 14:10:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch] s390: architecture co-maintainer.
Message-ID: <20060816121056.GI24551@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] architecture co-maintainer.

Add Heiko Carstens as co-maintainer for the s390 architecture.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

diff -urpN linux-2.6/MAINTAINERS linux-2.6-patched/MAINTAINERS
--- linux-2.6/MAINTAINERS	2006-08-16 13:36:56.000000000 +0200
+++ linux-2.6-patched/MAINTAINERS	2006-08-16 13:52:35.000000000 +0200
@@ -2439,6 +2439,8 @@ S:      Maintained
 S390
 P:	Martin Schwidefsky
 M:	schwidefsky@de.ibm.com
+P:	Heiko Carstens
+M:	heiko.carstens@de.ibm.com
 M:	linux390@de.ibm.com
 L:	linux-390@vm.marist.edu
 W:	http://www.ibm.com/developerworks/linux/linux390/
