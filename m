Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274904AbTHLADJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 20:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274918AbTHLADJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 20:03:09 -0400
Received: from [66.45.37.187] ([66.45.37.187]:35520 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S274904AbTHLADG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 20:03:06 -0400
Date: Mon, 11 Aug 2003 08:55:58 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p500
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Panic (NFS, 2.4.2[0-1])
In-Reply-To: <20030811104552.4e8972be.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.56.0308110855430.5520@p500>
References: <Pine.LNX.4.56.0308101710110.10609@p500> <20030811104552.4e8972be.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext2fs w/ 4096bytes per inode on all my Linux machines

On Mon, 11 Aug 2003, Stephan von Krawczynski wrote:

> On Sun, 10 Aug 2003 17:16:11 -0400 (EDT)
> war <war@lucidpixels.com> wrote:
>
> > >From /etc/fstab:
> > p500:/d1/x       /p500/x          nfs         rw,hard,intr,rsize=65536,wsize=65536,nfsvers=3 0 0
> >
> > A small for loop in bash causes 2.4.20 to panic, and 2.4.21 to have
> > massive network packet loss.
>
> What filesystem are you using?
>
> Regards,
> Stephan
>
>
