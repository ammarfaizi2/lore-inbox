Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317326AbSIATAG>; Sun, 1 Sep 2002 15:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317349AbSIATAG>; Sun, 1 Sep 2002 15:00:06 -0400
Received: from p508EAA3C.dip.t-dialin.net ([80.142.170.60]:15621 "EHLO
	tigra.home") by vger.kernel.org with ESMTP id <S317326AbSIATAG>;
	Sun, 1 Sep 2002 15:00:06 -0400
Date: Sun, 1 Sep 2002 21:04:51 +0200
From: Alex Riesen <fork0@users.sf.net>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre1-ac1: Filesystem panic attempting to mount ext3
Message-ID: <20020901190451.GA24693@steel>
Reply-To: Alex Riesen <fork0@users.sf.net>
References: <20020901071327.GA404@steel> <87k7m5hccc.fsf@devron.myhome.or.jp> <20020901173036.GA20418@steel> <87n0r1h6tv.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87n0r1h6tv.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi, Sun, Sep 01, 2002 21:02:04 +0200:
> Well, the filesystem is detected by the mount command, except the root
> filesystem. And mount command detects FAT before EXT3.

A. That explains everything.

-alex
