Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135945AbRDTPdc>; Fri, 20 Apr 2001 11:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135946AbRDTPdL>; Fri, 20 Apr 2001 11:33:11 -0400
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:14018 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S135945AbRDTPdE>; Fri, 20 Apr 2001 11:33:04 -0400
Date: Fri, 20 Apr 2001 16:33:03 +0100
From: Tim Waugh <tim@cyberelk.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.4-pre5: kernel-api.tmpl patch for fbcon
Message-ID: <20010420163302.A18720@cyberelk.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although it's referenced in kernel-api.tmpl, fbcon.c has no
extractable documentation.

Tim.
*/

--- linux/Documentation/DocBook/kernel-api.tmpl.fbcon	Fri Apr 20 16:30:55 2001
+++ linux/Documentation/DocBook/kernel-api.tmpl	Fri Apr 20 16:31:20 2001
@@ -255,9 +255,6 @@
      <sect1><title>Frame Buffer Memory</title>
 !Edrivers/video/fbmem.c
      </sect1>
-     <sect1><title>Frame Buffer Console</title>
-!Edrivers/video/fbcon.c
-     </sect1>
      <sect1><title>Frame Buffer Colormap</title>
 !Edrivers/video/fbcmap.c
      </sect1>
