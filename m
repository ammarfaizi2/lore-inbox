Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWH1TRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWH1TRW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWH1TRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:17:22 -0400
Received: from lucidpixels.com ([66.45.37.187]:60121 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751361AbWH1TRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:17:21 -0400
Date: Mon, 28 Aug 2006 15:17:21 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: linux-kernel@vger.kernel.org
cc: debian-user@lists.debian.org
Subject: 2.6.17.6 i810 + drm:810_wait_ring - kernel crash, help?
Message-ID: <Pine.LNX.4.64.0608281515250.29490@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aug 28 14:26:48 localhost kernel: [4307635.448000] [drm:i810_wait_ring] 
*ERROR* space: 64792 wanted 65528
Aug 28 14:26:48 localhost kernel: [4307635.448000] [drm:i810_wait_ring] 
*ERROR* lockup
Aug 28 14:26:50 localhost kdm[1754]: X server for display :0 terminated 
unexpectedly

Any idea why this occured? Should I turn-off DRM in my xorg.conf file? 
Using Debian Etch here..

Any idea, has anyone seen this before?
