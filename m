Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbTHFOwT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 10:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTHFOwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 10:52:18 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:17615 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263737AbTHFOwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 10:52:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16177.5641.6571.273023@gargle.gargle.HOWL>
Date: Wed, 6 Aug 2003 16:51:52 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: faith@valinux.com
Subject: any DRM update scheduled for 2.4.23-pre?
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anyone planning to update the apparently obsolete(*)
DRM drivers currently in 2.4.22-pre/rc for 2.4.23?

I noticed that the RH9 kernel applies a drm-4.3 patch,
so the code must be there, just not in Marcelo's tree :-(

(*) XFree86-4.3.0 tells me my radeon module from 2.4.22-pre10
is out of date, and glxgears runs like molasses :-(
With 2.6.0-test2, the X server doesn't complain, and rendering
performance is an order of magnitude better.

/Mikael
