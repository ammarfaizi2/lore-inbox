Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280727AbRKBQi5>; Fri, 2 Nov 2001 11:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280728AbRKBQir>; Fri, 2 Nov 2001 11:38:47 -0500
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:20864
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S280727AbRKBQil>; Fri, 2 Nov 2001 11:38:41 -0500
Date: Fri, 2 Nov 2001 08:38:21 -0800
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200111021638.fA2GcLs03275@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Alan Cox <laughing@shared-source.org>
Subject: Re: Linux 2.4.13-ac6
In-Reply-To: <20011102142512.A9558@lightning.swansea.linux.org.uk>
In-Reply-To: <20011102142512.A9558@lightning.swansea.linux.org.uk>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, Alan Cox wrote:

> 2.4.13-ac6
> o	IDE driver updates				(Andre Hedrick
> 							 Michael Cornwell)
> 	| Taskfile framework
> 	| Disk suspend cache flushing
> 	| Driver updates
> 	| UDMA133

This adds four config options without any Configure.help text:

CONFIG_IDEDISK_STROKE
CONFIG_IDE_TASK_IOCTL
CONFIG_IDEDMA_ONLYDISK
CONFIG_BLK_DEV_IDEDMA_TIMEOUT

Is there any documentation somewhere else for these?  In particular I
get what most of them mean but don't understand what IDE Taskfile is.

Cheers, Wayne

