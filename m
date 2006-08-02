Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWHBGYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWHBGYr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 02:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWHBGYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 02:24:47 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:41960 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751245AbWHBGYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 02:24:46 -0400
Date: Wed, 2 Aug 2006 08:22:02 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Scott J. Harmon" <harmon@ksu.edu>
cc: Pavel Machek <pavel@ucw.cz>, Hans Reiser <reiser@namesys.com>,
       Denis Vlasenko <vda.linux@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: reiser4: maybe just fix bugs?
In-Reply-To: <44CF5E26.50702@ksu.edu>
Message-ID: <Pine.LNX.4.61.0608020818010.7593@yvahk01.tjqt.qr>
References: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com>
 <44CEBCBC.9070707@namesys.com> <20060801103714.GA2310@elf.ucw.cz>
 <44CF5E26.50702@ksu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> fsck.ext2/fsck.vfat/... follow some convention including naming,
>> command line switches, and behaviour.
>> 
>> Like fsck.ext2 /dev/something is enough to check the fielsystem.
>
>
>> reiserfsck is missnamed (should be fsck.reiser), and it likes to chat
>> with you -- which is unexpected for tools.
>
>Yeah, I would never imagine that for ext2 and ext3 fsck might be called
>'e2fsck'. ;-)

So everyone plays his game...

xfs_check
jfs_fsck
dosfsck

I don't see why reiserfsck should be out of line...



Jan Engelhardt
-- 
