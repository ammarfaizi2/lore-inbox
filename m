Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317058AbSHAVEF>; Thu, 1 Aug 2002 17:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSHAVEF>; Thu, 1 Aug 2002 17:04:05 -0400
Received: from www.transvirtual.com ([206.14.214.140]:10248 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S317058AbSHAVEE>; Thu, 1 Aug 2002 17:04:04 -0400
Date: Thu, 1 Aug 2002 14:07:19 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Nico Schottelius <nico-mutt@schottelius.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bugs in 2.5.28 [scsi/framebuffer/devfs/floppy/ntfs/trident]
In-Reply-To: <20020731215806.GE3464@schottelius.org>
Message-ID: <Pine.LNX.4.44.0208011404360.18265-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Ug. That is partially fixed. I did get the other vc/X but only root can
> > access them. I have to talk to linus about the best solution here.
>
> What about the patch with con_init_devfs(); ? Isn't that simple and stupid
> enough to use ? [this is the only way I can work with those kernels right
> now..]

Try my patch now and tell me how it works.

http://www.transvirtual.com/~jsimmons/console.diff.gz

Against Linus current BK tree.


