Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265947AbTBGQFq>; Fri, 7 Feb 2003 11:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265895AbTBGQFq>; Fri, 7 Feb 2003 11:05:46 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:60555 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S265880AbTBGQFp>;
	Fri, 7 Feb 2003 11:05:45 -0500
Date: Fri, 7 Feb 2003 17:15:44 +0100 (CET)
From: Stephan van Hienen <raid@a2000.nu>
To: Wim Vinckier <wim-raid@tisnix.be>
cc: kernel@ddx.a2000.nu, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: fsck out of memory
In-Reply-To: <Pine.LNX.4.33.0302071703100.12705-100000@nooks.wimpunk.com>
Message-ID: <Pine.LNX.4.53.0302071711260.1306@ddx.a2000.nu>
References: <Pine.LNX.4.33.0302071703100.12705-100000@nooks.wimpunk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2003, Wim Vinckier wrote:

> I'm just wondering why you are using ext2 in stead of ext3 or reiserfs...
i'm running ext3
but crash was heavy enough for removing the journal info :(

> I would still give it a try to boot my system without mounting the raid so
> you just can wait untill the raid is synchronized.  Once this is ready,
i can mount the filesystem, but get errors on accessing some files
so i prefer to run fsck on it (and restore the journal info)

> you can check your raid.  BTW, I had two fans blowing air over my
> harddisks but I got the crash because I used the normal flat IDE-cable...
> I suppose you really checked the heat of the disks?
yes i did

