Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965386AbWCTPnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965386AbWCTPnP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965287AbWCTPYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:24:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13496 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965282AbWCTPX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:23:59 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 009/141] V4L/DVB (3406): Added credits for em28xx-video.c
Date: Mon, 20 Mar 2006 12:08:38 -0300
Message-id: <20060320150838.PS565965000009@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: 1138043454 -0200

- Added credits for sn9c102 kernel module and his author as
some parts of em28xx-video were based.

Acked-by: Luca Risolia <luca.risolia@studio.unibo.it>
Acked-by: Markus Rechberger <mrechberger@gmail.com>
Acked-by: Ludovico Cavedon <cavedon@sssup.it>
Acked-by: Sascha Sommer <saschasommer@freenet.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
index eea304f..94a14a2 100644
--- a/drivers/media/video/em28xx/em28xx-video.c
+++ b/drivers/media/video/em28xx/em28xx-video.c
@@ -6,6 +6,9 @@
 		      Mauro Carvalho Chehab <mchehab@brturbo.com.br>
 		      Sascha Sommer <saschasommer@freenet.de>
 
+	Some parts based on SN9C10x PC Camera Controllers GPL driver made
+		by Luca Risolia <luca.risolia@studio.unibo.it>
+
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or

