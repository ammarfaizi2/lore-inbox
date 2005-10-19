Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbVJSBiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVJSBiG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbVJSBhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:37:23 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:32275 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932435AbVJSBdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:33:09 -0400
Date: Tue, 18 Oct 2005 21:31:00 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jgarzik@pobox.com, shemminger@osdl.org, mlindner@syskonnect.de,
       rroesler@syskonnect.de
Subject: [patch 2.6.14-rc4 2/3] MAINTAINERS: mark the sk98lin driver as obsolete
Message-ID: <10182005213100.12420@bilbo.tuxdriver.com>
In-Reply-To: <10182005213100.12360@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sk98lin and skge drivers cover the same set of hardware, and the
skge driver enjoys community support.  This patch marks the sk98lin
driver as obsolete.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 MAINTAINERS |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1592,7 +1592,7 @@ M: 	mlindner@syskonnect.de
 P:	Ralph Roesler
 M: 	rroesler@syskonnect.de
 W: 	http://www.syskonnect.com
-S: 	Supported
+S: 	Obsolete
 
 MAESTRO PCI SOUND DRIVERS
 P:	Zach Brown
