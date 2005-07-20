Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVGTJXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVGTJXP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 05:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVGTJXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 05:23:15 -0400
Received: from mail.portrix.net ([212.202.157.208]:41119 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261475AbVGTJWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 05:22:40 -0400
Message-ID: <42DE17DC.7050506@ppp0.net>
Date: Wed, 20 Jul 2005 11:22:36 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: linux-kernel@vger.kernel.org
Subject: defconfig for v850, please
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles,

while you're at it patching v850 here and there, could you please
also provide a resonable defconfig for v850, so that
$ make ARCH=v850 CROSS_COMPILE=... defconfig
$ make ARCH=v850 CROSS_COMPILE=...

works? Then my cross-compile tests at http://l4x.org/k could
probably provide somewhat meanigful results for this arch?!

Thanks,

-- 
Jan
