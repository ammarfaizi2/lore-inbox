Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275576AbRIZUTM>; Wed, 26 Sep 2001 16:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275577AbRIZUTD>; Wed, 26 Sep 2001 16:19:03 -0400
Received: from mpdr0.columbus.oh.ameritech.net ([206.141.239.62]:52659 "EHLO
	mailhost.col.ameritech.net") by vger.kernel.org with ESMTP
	id <S275576AbRIZUSt>; Wed, 26 Sep 2001 16:18:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bobby Bingham <uhmmmm@ameritech.net>
Reply-To: uhmmmm@ameritech.net
To: linux-kernel@vger.kernel.org
Subject: SiS 7018 sound chipset
Date: Wed, 26 Sep 2001 16:18:17 -0400
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010926201909.LBAG26084.mailhost.col.ameritech.net@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
	I while ago, I upgraded my computer, and my new motherboard has a SiS 7018 
sound chipset onboard.  I noticed after the upgrade that running games with 
WINE that use DirectSound wouldn't produce sound.  At first I thought it 
might be a new bug in WINE, but then I noticed that the linux versions of 
Quake3 and the new Castle Wolfenstein Multiplayer Test suffer the same 
problem, although Unreal Tournament does not.  Quake3 and Wolfenstein both 
tell me that the "sound system is muted."  This didn't happen with my old ISA 
sound card, but my new motherboard doesn't have any ISA slots :-(  Could 
anybody shed some light on this, or even a possible fix?  I'd try myself, but 
so far my entire experience with the kernel source has been configure, 
compile, install.  I am using kernel 2.4.9-ac14 with the OSS ac97_codec and 
trident modules.

Bobby Bingham

Please CC me as I'm not subscribed
-- 
Microsoft Windows: Made for the internet
The Internet: Made for UNIX
