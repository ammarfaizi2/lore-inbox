Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWCTPY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWCTPY6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965292AbWCTPY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:24:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22968 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965291AbWCTPYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:24:54 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 082/141] V4L/DVB (3334): Added ET61X251 fourcc type
Date: Mon, 20 Mar 2006 12:08:50 -0300
Message-id: <20060320150850.PS715687000082@infradead.org>
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
Date: 1141009660 -0300

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/include/linux/videodev2.h b/include/linux/videodev2.h
diff --git a/include/linux/videodev2.h b/include/linux/videodev2.h
index 1dd8efe..3f15043 100644
--- a/include/linux/videodev2.h
+++ b/include/linux/videodev2.h
@@ -326,6 +326,7 @@ struct v4l2_pix_format
 #define V4L2_PIX_FMT_SN9C10X  v4l2_fourcc('S','9','1','0') /* SN9C10x compression */
 #define V4L2_PIX_FMT_PWC1     v4l2_fourcc('P','W','C','1') /* pwc older webcam */
 #define V4L2_PIX_FMT_PWC2     v4l2_fourcc('P','W','C','2') /* pwc newer webcam */
+#define V4L2_PIX_FMT_ET61X251 v4l2_fourcc('E','6','2','5') /* ET61X251 compression */
 
 /*
  *	F O R M A T   E N U M E R A T I O N

