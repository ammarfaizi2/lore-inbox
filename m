Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317802AbSFSHUZ>; Wed, 19 Jun 2002 03:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317803AbSFSHUY>; Wed, 19 Jun 2002 03:20:24 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:23822 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317802AbSFSHUY>; Wed, 19 Jun 2002 03:20:24 -0400
Date: Wed, 19 Jun 2002 09:20:16 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.18] vfat doesn't support files > 2GB under Linux, under Windoze it does
Message-ID: <20020619072016.GA28198@louise.pinerecords.com>
References: <20020617225149.56796.qmail@web14604.mail.yahoo.com> <87sn3kf9ce.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sn3kf9ce.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 14 days, 23:01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > This patch break some filesystems (adfs, affs, hfs, hpfs, qnx4).
> > > And I haven't fixed them yet. So, I can't submit this patch.
> > > 
> > > If it's OK, I'll make the patch for 2.4.18.
> > 
> > 
> > Any update on the patch yet?
> 
> Whether it's needed, there is patch of fat for 2.4.18 and 2.5.19, here.

Any chance you're sending this to Marcelo for possible inclusion in 2.4.20?

T.
