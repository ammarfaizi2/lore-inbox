Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWH1XKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWH1XKW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 19:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWH1XKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 19:10:22 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:30923 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S1751464AbWH1XKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 19:10:21 -0400
Date: Tue, 29 Aug 2006 08:10:19 +0900 (JST)
Message-Id: <20060829.081019.130229757.kkojima@rr.iij4u.or.jp>
To: linux-kernel@vger.kernel.org
Subject: Step down from maintainerships
From: Kaz Kojima <kkojima@rr.iij4u.or.jp>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think this is a time to step down from my SUPERH architecture
maintainerships.  The major development issues for this port
seem to shift on the hardwares I can't access and I have no
recent activity on kernel.  I shouldn't qualify as a maintainer
of SUPERH port now and there is no problem because Paul is
actively maintaining it.  The attached patch drops my name,
address and web URL from MAINTAINERS file.

Regards,
	kaz
--

Signed-Off-By: Kazumoto Kojima <kkojima@rr.iij4u.or.jp>

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bab239..52d7b8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2768,12 +2768,9 @@ S:	Maintained
 SUPERH (sh)
 P:	Paul Mundt
 M:	lethal@linux-sh.org
-P:	Kazumoto Kojima
-M:	kkojima@rr.iij4u.or.jp
 L:	linuxsh-dev@lists.sourceforge.net
 W:	http://www.linux-sh.org
 W:	http://www.m17n.org/linux-sh/
-W:	http://www.rr.iij4u.or.jp/~kkojima/linux-sh4.html
 S:	Maintained
 
 SUPERH64 (sh64)
