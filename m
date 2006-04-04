Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWDECzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWDECzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 22:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWDECzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 22:55:50 -0400
Received: from koto.vergenet.net ([210.128.90.7]:49083 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1751085AbWDECzu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 22:55:50 -0400
Date: Wed, 5 Apr 2006 08:48:08 +0900
From: Horms <horms@verge.net.au>
To: linux-kernel@vger.kernel.org, fastboot@osdl.org
Cc: Eric Biederman <ebiederm@xmission.com>,
       Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] kexec: typo in machine_kexec()
Message-ID: <20060404234806.GA25761@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-Off-By: Horms <horms@verge.net.au

 machine_kexec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

b242c77f387d75d1bfa377d1870c0037d9e0c364
diff --git a/arch/i386/kernel/machine_kexec.c b/arch/i386/kernel/machine_kexec.c
index f73d737..beaad58 100644
--- a/arch/i386/kernel/machine_kexec.c
+++ b/arch/i386/kernel/machine_kexec.c
@@ -194,7 +194,7 @@ NORET_TYPE void machine_kexec(struct kim
 	 * set them to a specific selector, but this table is never
 	 * accessed again you set the segment to a different selector.
 	 *
-	 * The more common model is are caches where the behide
+	 * The more common model is are caches where the behind
 	 * the scenes work is done, but is also dropped at arbitrary
 	 * times.
 	 *
