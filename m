Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317906AbSFSPMM>; Wed, 19 Jun 2002 11:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317912AbSFSPML>; Wed, 19 Jun 2002 11:12:11 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:42764 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S317906AbSFSPMJ>; Wed, 19 Jun 2002 11:12:09 -0400
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.18] vfat doesn't support files > 2GB under Linux, under Windoze it does
References: <20020617225149.56796.qmail@web14604.mail.yahoo.com>
	<87sn3kf9ce.fsf@devron.myhome.or.jp>
	<20020619072016.GA28198@louise.pinerecords.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 20 Jun 2002 00:11:36 +0900
In-Reply-To: <20020619072016.GA28198@louise.pinerecords.com>
Message-ID: <87sn3jfglz.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe <szepe@pinerecords.com> writes:

> > > > This patch break some filesystems (adfs, affs, hfs, hpfs, qnx4).
> > > > And I haven't fixed them yet. So, I can't submit this patch.
> > > > 
> > > > If it's OK, I'll make the patch for 2.4.18.
> > > 
> > > 
> > > Any update on the patch yet?
> > 
> > Whether it's needed, there is patch of fat for 2.4.18 and 2.5.19, here.
> 
> Any chance you're sending this to Marcelo for possible inclusion in 2.4.20?

Before, I want to some test on 2.5.x at least. After it, I'll try to
submit a patch...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
