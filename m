Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270139AbTGVIOA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 04:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270151AbTGVIOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 04:14:00 -0400
Received: from quechua.inka.de ([193.197.184.2]:39646 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S270139AbTGVIN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 04:13:59 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: SVR4 STREAMS (for example LiS)
In-Reply-To: <3F1CE6B6.4020909@softhome.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19esW4-0000k8-00@calista.inka.de>
Date: Tue, 22 Jul 2003 10:29:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3F1CE6B6.4020909@softhome.net> you wrote:
> [1] <blatant rant on>I absolutely do not need to use 64GB of memory - 
> but kernel includes HIGH_MEM support.

of course if you do not enable HIGH_MEM support your 2.4 kernel will only allow
960MB of main memory, so I dont think this is bloat and unneeded.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
