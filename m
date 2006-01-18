Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbWARWo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbWARWo7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWARWo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:44:59 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:13317 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932570AbWARWo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:44:58 -0500
Date: Wed, 18 Jan 2006 17:44:53 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net
Subject: [patch 2/2] MAINTAINERS: add entry for wireless networking
Message-ID: <20060118224453.GG6583@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net
References: <20060118224300.GF6583@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118224300.GF6583@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry to MAINTAINERS for wireless networking, just so people
know whom to bless with patches.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6d1b048..23aca6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1844,6 +1844,13 @@ L:	netdev@vger.kernel.org
 T:	git kernel.org:/pub/scm/linux/kernel/git/davem/net-2.6.git
 S:	Maintained
 
+NETWORKING [WIRELESS]
+P:	John W. Linville
+M:	linville@tuxdriver.com
+L:	netdev@vger.kernel.org
+T:	git kernel.org:/pub/scm/linux/kernel/git/linville/wireless-2.6.git
+S:	Maintained
+
 IPVS
 P:	Wensong Zhang
 M:	wensong@linux-vs.org
-- 
John W. Linville
linville@tuxdriver.com
