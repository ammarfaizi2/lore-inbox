Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932761AbWCQU4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932761AbWCQU4M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932762AbWCQU4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:56:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57770 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932761AbWCQU4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:56:12 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 09/21] Cleanup mangled whitespace
Date: Fri, 17 Mar 2006 17:54:35 -0300
Message-id: <20060317205435.PS18075100009@infradead.org>
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
Date: 1142232104 \-0300

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-cards.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/video/cx88/cx88-cards.c b/drivers/media/video/cx88/cx88-cards.c
index 7471a7d..0e518e8 100644
--- a/drivers/media/video/cx88/cx88-cards.c
+++ b/drivers/media/video/cx88/cx88-cards.c
@@ -323,19 +323,19 @@ struct cx88_board cx88_boards[] = {
 		.input          = {{
 			.type   = CX88_VMUX_TELEVISION,
 			.vmux   = 0,
-                       .gpio0  = 0xbff0,
+			.gpio0  = 0xbff0,
 		},{
 			.type   = CX88_VMUX_COMPOSITE1,
 			.vmux   = 1,
-                       .gpio0  = 0xbff3,
+			.gpio0  = 0xbff3,
 		},{
 			.type   = CX88_VMUX_SVIDEO,
 			.vmux   = 2,
-                       .gpio0  = 0xbff3,
+			.gpio0  = 0xbff3,
 		}},
 		.radio = {
 			.type   = CX88_RADIO,
-                       .gpio0  = 0xbff0,
+			.gpio0  = 0xbff0,
 		},
 	},
 	[CX88_BOARD_ASUS_PVR_416] = {

