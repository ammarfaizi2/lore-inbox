Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268149AbTB1Uou>; Fri, 28 Feb 2003 15:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268150AbTB1Uou>; Fri, 28 Feb 2003 15:44:50 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:10870 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268149AbTB1Uot>; Fri, 28 Feb 2003 15:44:49 -0500
Date: Fri, 28 Feb 2003 15:55:09 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200302282055.h1SKt9f01603@devserv.devel.redhat.com>
To: Duncan Sands <baldrick@wanadoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB speedtouch: don't race the tasklets
In-Reply-To: <mailman.1046424703.308.linux-kernel2news@redhat.com>
References: <mailman.1046424703.308.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  speedtouch.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

My news gateway ate all interesting headers, so I cannot tell
if you cc-ed it properly. The common practice is to send
patches to: greg@kroah.com and cc: linux-usb-devel@lists.sourceforge.net.
Linus probably won't pick anything USB directly off l-k.

-- Pete
