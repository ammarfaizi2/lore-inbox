Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932767AbWCQU7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbWCQU7d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932775AbWCQU6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:58:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6315 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932768AbWCQU5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:57:38 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 13/21] Whitespace: fix incorrect indentation of curly
	bracket
Date: Fri, 17 Mar 2006 17:54:36 -0300
Message-id: <20060317205436.PS42253100013@infradead.org>
In-Reply-To: <20060317205359.PS65198900000@infradead.org>
References: <20060317205359.PS65198900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael Krufky <mkrufky@linuxtv.org>
Date: 1142363929 \-0300

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/saa7134/saa7134-cards.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/saa7134/saa7134-cards.c b/drivers/media/video/saa7134/saa7134-cards.c
index 6bc63a4..5b5e378 100644
--- a/drivers/media/video/saa7134/saa7134-cards.c
+++ b/drivers/media/video/saa7134/saa7134-cards.c
@@ -536,7 +536,7 @@ struct saa7134_board saa7134_boards[] = 
 		.radio = {
 			.name = name_radio,
 			.amux = LINE2,
-	},
+		},
 	},
 	[SAA7134_BOARD_MD7134] = {
 		.name           = "Medion 7134",

