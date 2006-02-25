Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161075AbWBYTIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbWBYTIp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 14:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWBYTIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 14:08:02 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:9615 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1161068AbWBYTH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 14:07:57 -0500
Date: Sat, 25 Feb 2006 16:08:30 -0300
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: davem <davem@davemloft.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       robert.olsson@its.uu.se
Subject: [PATCH 6/6] pktgen: Updates version.
Message-ID: <20060225160830.4f690931@home.brethil>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 With all the previous changes, we're at a new version now.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

---

 net/core/pktgen.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

32d9b9951586e505b4b8bc587f9e170612a48a4d
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 5d13626..2221b86 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -153,7 +153,7 @@
 #include <asm/div64.h>		/* do_div */
 #include <asm/timex.h>
 
-#define VERSION  "pktgen v2.64: Packet Generator for packet performance testing.\n"
+#define VERSION  "pktgen v2.65: Packet Generator for packet performance testing.\n"
 
 /* #define PG_DEBUG(a) a */
 #define PG_DEBUG(a)
-- 
1.2.1.g3397f9

-- 
Luiz Fernando N. Capitulino
