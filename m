Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265612AbTGLNVT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 09:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265617AbTGLNVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 09:21:19 -0400
Received: from RJ161046.user.veloxzone.com.br ([200.149.161.46]:4339 "EHLO
	mf.dnsalias.org") by vger.kernel.org with ESMTP id S265612AbTGLNVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 09:21:18 -0400
Subject: Re: [patch] SCHED_SOFTRR linux scheduler policy ...
From: Miguel Freitas <miguel@cetuc.puc-rio.br>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Jul 2003 10:43:10 -0300
Message-Id: <1058017391.1197.24.camel@mf>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davide,

I've found your SCHED_SOFTRR patch pretty interesting, the idea sounds
amazingly simple and effective :)

Some months ago i did experiments with multimedia performance on linux
kernel and ideas on what could be improved.

http://cambuca.ldhs.cetuc.puc-rio.br/~miguel/multimedia_sim/

I think it should be a general consensus that joe user must not need to
patch his kernel or run the multimedia player as root just to be able to
watch videos with good quality.

As a xine developer i'm very interested in help improving that
situation. Please let me know if you think this patch has chance of
being accepted into main tree, we can add support in xine for it.

regards,

Miguel

