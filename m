Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWEPVdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWEPVdq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWEPVdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:33:46 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38667 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932137AbWEPVdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:33:45 -0400
Date: Tue, 16 May 2006 23:33:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Theodore Tso <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] fs/jbd/journal.c: possible cleanups
Message-ID: <20060516213344.GT10077@stusta.de>
References: <20060516174413.GI10077@stusta.de> <20060516122731.6ecbdeeb.akpm@osdl.org> <20060516193956.GS10077@stusta.de> <20060516211430.GA9571@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516211430.GA9571@thunk.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 05:14:30PM -0400, Theodore Tso wrote:
> On Tue, May 16, 2006 at 09:39:56PM +0200, Adrian Bunk wrote:
> > Since you replied to this patch:
> > Who is the subsystem maintainer for jbd?
> 
> I'd suggest sending mail to ext2-devel@lists.sourceforge.net.  There's
> actually a lot of work going on right now with both ext3 and jbd right
> now, including finally getting the 64-bit support for jbd merged in.

What about getting a MAINTAINERS entry for jbd?

The only current entry listing ext2-devel@lists.sourceforge.net is for 
ext2 which doesn't use jbd...

> 						- Ted

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

