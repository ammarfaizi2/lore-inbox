Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316113AbSHXNUG>; Sat, 24 Aug 2002 09:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316135AbSHXNUG>; Sat, 24 Aug 2002 09:20:06 -0400
Received: from quechua.inka.de ([212.227.14.2]:32352 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S316113AbSHXNUF>;
	Sat, 24 Aug 2002 09:20:05 -0400
From: Bernd Eckenfels <ecki-news2002-08@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH TRIVIAL]: repost 2.4.19/drivers/atm/iphase.c
In-Reply-To: <20020824030855.A2399@hamsec.aurora.sfo.interquest.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17iatn-0003aw-00@sites.inka.de>
Date: Sat, 24 Aug 2002 15:24:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020824030855.A2399@hamsec.aurora.sfo.interquest.net> you wrote:
> +       if (iadev->desc_tbl == NULL) return -EAGAIN;

is there a pattern in your patches? EAGAIN or ENOMEM?

Greetings
Bernd
