Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263232AbUJ2KoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263232AbUJ2KoX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 06:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263233AbUJ2KoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 06:44:23 -0400
Received: from mail.dif.dk ([193.138.115.101]:58813 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S263232AbUJ2KoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 06:44:19 -0400
Date: Fri, 29 Oct 2004 12:36:19 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: dan@fullmotions.com, linux-kernel@vger.kernel.org
Subject: Re: SSH and 2.6.9
In-Reply-To: <20041028022942.7ef1a8b8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0410291234530.22050@jjulnx.backbone.dif.dk>
References: <1098906712.2972.7.camel@hanzo.fullmotions.com>
 <Pine.LNX.4.61.0410272247460.3284@dragon.hygekrogen.localhost>
 <1098912301.4535.1.camel@hanzo.fullmotions.com> <1098913797.3495.0.camel@hanzo.fullmotions.com>
 <Pine.LNX.4.61.0410280034020.3284@dragon.hygekrogen.localhost>
 <20041028022942.7ef1a8b8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004, Andrew Morton wrote:

> Date: Thu, 28 Oct 2004 02:29:42 -0700
> From: Andrew Morton <akpm@osdl.org>
> To: Jesper Juhl <juhl-lkml@dif.dk>
> Cc: dan@fullmotions.com, linux-kernel@vger.kernel.org
> Subject: Re: SSH and 2.6.9
> 
> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> >
> > Now I guess we just need for someone to find out why LEGACY_PTYS breaks 
> >  ssh (and other apps?) with kernels >= 2.6.9,
> 
> Works OK here, witht he latest of everything.  Please send the faulty
> .config.
> 
> If you could generate the `strace -f' output from good and bad
> sessions and identify where things went wrong, that would help.
> 

I have no problem here, and I can't reproduce it by enabling LEGACY_PTYS 
either, so you'll have to get the .config and strace etc from Danny Brow.


--
Jesper Juhl

