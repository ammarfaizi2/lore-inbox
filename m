Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWAPJX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWAPJX5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWAPJXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:23:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40683 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932263AbWAPJXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:23:16 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 24/25] Samsung TBMV30111IN has 6 entries
Date: Mon, 16 Jan 2006 07:11:25 -0200
Message-id: <20060116091125.PS78716200024@infradead.org>
In-Reply-To: <20060116091105.PS83611600000@infradead.org>
References: <20060116091105.PS83611600000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael Krufky <mkrufky@m1k.net>

- Samsung TBMV30111IN has 6 entries

Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/frontends/dvb-pll.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/frontends/dvb-pll.c b/drivers/media/dvb/frontends/dvb-pll.c
index 757075f..1b9934e 100644
--- a/drivers/media/dvb/frontends/dvb-pll.c
+++ b/drivers/media/dvb/frontends/dvb-pll.c
@@ -333,7 +333,7 @@ struct dvb_pll_desc dvb_pll_tbmv30111in 
 	.name = "Samsung TBMV30111IN",
 	.min = 54000000,
 	.max = 860000000,
-	.count = 4,
+	.count = 6,
 	.entries = {
 		{ 172000000, 44000000, 166666, 0xb4, 0x01 },
 		{ 214000000, 44000000, 166666, 0xb4, 0x02 },

