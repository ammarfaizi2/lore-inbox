Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267484AbTAQKr7>; Fri, 17 Jan 2003 05:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267485AbTAQKr7>; Fri, 17 Jan 2003 05:47:59 -0500
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:21229 "EHLO
	rrzs2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S267484AbTAQKr6>; Fri, 17 Jan 2003 05:47:58 -0500
Date: Fri, 17 Jan 2003 11:56:56 +0100
From: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 and CONFIG_DRM_I810_XFREE_41
Message-ID: <20030117115656.C5069@pc9391.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

what's the story about CONFIG_DRM_I810_XFREE_41?
Let's say I set CONFIG_DRM_I810_XFREE_41=y; does this mean drm won't work 
anymore if I switch to XFree-4.2 or later ?

Can I diasble this feature (even when compiled in) by, maybe a boot-parameter 
or with the help of /proc ??


Christian
