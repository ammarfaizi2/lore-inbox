Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265987AbTBGP7v>; Fri, 7 Feb 2003 10:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265982AbTBGP7v>; Fri, 7 Feb 2003 10:59:51 -0500
Received: from eos.telenet-ops.be ([195.130.132.40]:20950 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S265898AbTBGP7t>; Fri, 7 Feb 2003 10:59:49 -0500
Date: Fri, 7 Feb 2003 17:09:25 +0100 (CET)
From: Wim Vinckier <wim-raid@tisnix.be>
X-X-Sender: <wim@nooks.wimpunk.com>
To: <kernel@ddx.a2000.nu>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: fsck out of memory
In-Reply-To: <Pine.LNX.4.53.0302071648250.1703@ddx.a2000.nu>
Message-ID: <Pine.LNX.4.33.0302071703100.12705-100000@nooks.wimpunk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2003 kernel@ddx.a2000.nu wrote:

> On Fri, 7 Feb 2003, Wim Vinckier wrote:
>
> > I've got an equivalent problem with my server.  After a long search, it
> > seemed to be a heating problem.  The ventilation wasn't good enough to
>
> disks are not warm at all
> there are 3 6000rpms fans blowing air over them
>

I'm just wondering why you are using ext2 in stead of ext3 or reiserfs...
I would still give it a try to boot my system without mounting the raid so
you just can wait untill the raid is synchronized.  Once this is ready,
you can check your raid.  BTW, I had two fans blowing air over my
harddisks but I got the crash because I used the normal flat IDE-cable...
I suppose you really checked the heat of the disks?

Wim.
------------------------------------------------------------------------
Wim VINCKIER
Wim-Raid@tisnix.be                                         ICQ 100545109
------------------------------------------------------------------------
'Windows 98 or better required' said the box... so I installed linux

