Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWDEPRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWDEPRH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 11:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWDEPRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 11:17:07 -0400
Received: from xenotime.net ([66.160.160.81]:31981 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750834AbWDEPRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 11:17:06 -0400
Date: Wed, 5 Apr 2006 08:19:20 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: horms@verge.net.au, linux-kernel@vger.kernel.org, fastboot@osdl.org,
       akpm <akpm@osdl.org>, torvalds <torvalds@osdl.org>
Subject: [PATCH] kexec: update MAINTAINERS
Message-Id: <20060405081920.3655ddb2.rdunlap@xenotime.net>
In-Reply-To: <m1mzf0in0n.fsf@ebiederm.dsl.xmission.com>
References: <20060404234806.GA25761@verge.net.au>
	<20060404200557.1e95bdd8.rdunlap@xenotime.net>
	<m1mzf0in0n.fsf@ebiederm.dsl.xmission.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Eric is the kexec maintainer.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 MAINTAINERS |    2 --
 1 files changed, 2 deletions(-)

--- linux-2617-rc1.orig/MAINTAINERS
+++ linux-2617-rc1/MAINTAINERS
@@ -1556,9 +1556,7 @@ S:	Maintained
 
 KEXEC
 P:	Eric Biederman
-P:	Randy Dunlap
 M:	ebiederm@xmission.com
-M:	rdunlap@xenotime.net
 W:	http://www.xmission.com/~ebiederm/files/kexec/
 L:	linux-kernel@vger.kernel.org
 L:	fastboot@osdl.org


---
