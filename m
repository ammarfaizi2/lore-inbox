Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbULES3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbULES3K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 13:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbULES3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 13:29:10 -0500
Received: from quechua.inka.de ([193.197.184.2]:48308 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261352AbULES3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 13:29:03 -0500
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ethX interface rx errors
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20041205194047.1C597440E2@service.i-think-future.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1Cb180-0004oH-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 05 Dec 2004 19:29:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20041205194047.1C597440E2@service.i-think-future.de> you wrote:
> Does anyone have an idea what may be the cause and how this problem
> could be solved?

> 9:     307291          XT-PIC  eth0, eth1

No idea, but try a non-shared interrupt.

Bernd
