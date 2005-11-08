Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbVKHQ24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbVKHQ24 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVKHQ24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:28:56 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:44014 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932467AbVKHQ2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:28:55 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] pktcdvd: Remove subscribers-only list
References: <m3mzkfayx5.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 08 Nov 2005 17:28:45 +0100
In-Reply-To: <m3mzkfayx5.fsf@telia.com>
Message-ID: <m3irv3ayte.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

Remove maintainer entry for a subscribers-only mailing list.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 MAINTAINERS |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 995bfd8..3028d4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1970,7 +1970,6 @@ PKTCDVD DRIVER
 P:	Peter Osterlund
 M:	petero2@telia.com
 L:	linux-kernel@vger.kernel.org
-L:	packet-writing@suse.com
 S:	Maintained
 
 POSIX CLOCKS and TIMERS

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
