Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310979AbSDEBz7>; Thu, 4 Apr 2002 20:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSDEBzu>; Thu, 4 Apr 2002 20:55:50 -0500
Received: from quechua.inka.de ([212.227.14.2]:24431 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S310979AbSDEBzn>;
	Thu, 4 Apr 2002 20:55:43 -0500
From: Bernd Eckenfels <ecki-news2002-03@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <Springmail.0994.1017964447.0.72656900@webmail.atl.earthlink.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E16tIx4-0002t1-00@sites.inka.de>
Date: Fri, 5 Apr 2002 03:55:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Springmail.0994.1017964447.0.72656900@webmail.atl.earthlink.net> you wrote:
>  Or is there another way of speeding up the linux kernel boot process?

Have you watched the boot process for long pause? SCSI Init and not found
devices can delay. if you make your own kernel with only the required
hardware (and perhaps put a lot into modules which are only used if needed)
this can help. Actually a faster init also does help.

Greetings
Bernd
