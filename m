Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312895AbSDEOwI>; Fri, 5 Apr 2002 09:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312898AbSDEOv7>; Fri, 5 Apr 2002 09:51:59 -0500
Received: from pD9001BAF.dip.t-dialin.net ([217.0.27.175]:13803 "EHLO
	zeus.prom.vpn") by vger.kernel.org with ESMTP id <S312895AbSDEOvw>;
	Fri, 5 Apr 2002 09:51:52 -0500
Subject: [PATCH] [CLEANUP] radeonfb accelerator id in 2.4.19
From: Ingo Albrecht <prom@berlin.ccc.de>
To: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: Linux Framebuffer Development List 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 05 Apr 2002 16:51:10 +0200
Message-Id: <1018018270.30211.259.camel@zeus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This small patch assigns an accelerator id to radeonfb.
The reason for this should be obvious.

This is against 2.4.19-pre6, but making it apply against
something else shouldnt be a lot of work ;)

I read LKML, but not fbdev-devel.

Ingo

-- 
Let the people think they govern and they will be governed.
                -- William Penn, founder of Pennsylvania
