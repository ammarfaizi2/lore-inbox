Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314465AbSD1TYx>; Sun, 28 Apr 2002 15:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314469AbSD1TYw>; Sun, 28 Apr 2002 15:24:52 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:19616 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314465AbSD1TYw>;
	Sun, 28 Apr 2002 15:24:52 -0400
Date: Sun, 28 Apr 2002 21:24:29 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [bk+patch] Let (WIP) be replaced with (EXPERIMENTAL)
Message-ID: <20020428212429.A12005@ucw.cz>
In-Reply-To: <20020428142415.A10747@ucw.cz> <3CCBFAB6.7060607@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2002 at 03:35:50PM +0200, Martin Dalecki wrote:

> Uz.ytkownik Vojtech Pavlik napisa?:
> > ChangeSet@1.571, 2002-04-28 14:22:33+02:00, vojtech@twilight.ucw.cz
> >   This removes the CONFIG_IDEDMA_PCI_WIP option, replacing it with
> >   the more common CONFIG_EXPERIMENTAL. It also adds a depencency
> >   on $CONFIG_EXPERIMENTAL where missing.
> 
> 
> All fine and all will be taken. However please note that
> I don't use BK and I don't intend too. My rejection of
> it isn't based on any idiotic policy - I found it just ugly to
> use and I was confused about the beta-alpha versions
> offered on the web site - too much work in progress for my taste.
> Finally I don't entrust source code to programmers who even don't know
> the difference between TCP and UDP and use TCP becouse they don't know better.

Ok - your decision. If you want, I'll omit the BK part of the patches.
On the other hand, if you could just forward it to Linus as is (or let
me send it to Linus after your confirmation), change comments won't get
lost. 

> I preferr a classical diff -urN ;-).

It's included, anyway.

-- 
Vojtech Pavlik
SuSE Labs
