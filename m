Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267215AbTBIMVc>; Sun, 9 Feb 2003 07:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbTBIMV3>; Sun, 9 Feb 2003 07:21:29 -0500
Received: from kim.it.uu.se ([130.238.12.178]:33411 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S267215AbTBIMV2>;
	Sun, 9 Feb 2003 07:21:28 -0500
Date: Sun, 9 Feb 2003 13:31:09 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200302091231.NAA13991@kim.it.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.4.5 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr-2.4.5 is now available at the usual place:
http://www.csd.uu.se/~mikpe/linux/perfctr/

This just is a minor maintenance release, before the API
fixes and extensions which are scheduled for perfctr-2.5.

Version 2.4.5, 2003-02-09
- Corrected the unit mask definition for the K7 SYSTEM_REQUEST_TYPE
  event in etc/perfctr-events.tab: WC is 0x02 not 0x04.
- Fixed two compile warnings which could be triggered in 2.5 kernels.
- Patch kit updates for 2.4.21-pre4/2.4.18-24(RedHat)/2.5.59-osdl2 kernels.

/ Mikael Pettersson
