Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWCMT4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWCMT4r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWCMT4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:56:47 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50957 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932404AbWCMT4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:56:46 -0500
Date: Mon, 13 Mar 2006 20:56:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>, perex@suse.cz, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] ALSA-Configuration.txt: snd-hda-intel: document model=basic
Message-ID: <20060313195644.GF13973@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Document the model=basic option in the snd-hda-intel driver.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

Can I get an ACK for getting this patch into 2.6.16?

This patch was already sent on:
- 4 Mar 2006

--- linux-2.6.16-rc5-mm2-full/Documentation/sound/alsa/ALSA-Configuration.txt.old	2006-03-04 15:52:50.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/Documentation/sound/alsa/ALSA-Configuration.txt	2006-03-04 15:57:10.000000000 +0100
@@ -705,6 +705,7 @@
 			$CONFIG_SND_DEBUG=y
 
 	ALC260
+	  basic		base mode
 	  hp		HP machines
 	  fujitsu	Fujitsu S7020
 


