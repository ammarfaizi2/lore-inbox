Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbTIPDOa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 23:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbTIPDMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 23:12:18 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:52865 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261784AbTIPDLo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 23:11:44 -0400
Message-ID: <1063681840.3f667f30d7f65@dubai.stillhq.com>
Date: Tue, 16 Sep 2003 13:10:40 +1000
From: Michael Still <mikal@stillhq.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [2.6 Patch] Kernel-doc updates 15 of 15 -- /sound/oss/via82cxxx_audio.c
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 203.17.68.210
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes kernel-doc errors reported whilst doing
a make mandocs on 2.6-test4-bk5

Linus, please apply.

Cheers,
Mikal


--------------------------


diff -Nur linux-2.6.0-test4-bk5-mandocs/sound/oss/via82cxxx_audio.c
linux-2.6.0-test4-bk5-mandocs_tweaks/sound/oss/via82cxxx_audio.c
--- linux-2.6.0-test4-bk5-mandocs/sound/oss/via82cxxx_audio.c	2003-09-04
10:57:16.000000000 +1000
+++ linux-2.6.0-test4-bk5-mandocs_tweaks/sound/oss/via82cxxx_audio.c	2003-09-06
13:47:19.000000000 +1000
@@ -1844,6 +1844,7 @@
 
 /**
  *	via_intr_channel - handle an interrupt for a single channel
+ *      @card: unused
  *	@chan: handle interrupt for this channel
  *
  *	This is the "meat" of the interrupt handler,

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson


-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
