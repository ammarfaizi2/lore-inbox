Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264702AbUEEXlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264702AbUEEXlp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 19:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264699AbUEEXlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 19:41:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4038 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264702AbUEEXlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 19:41:44 -0400
Date: Thu, 6 May 2004 01:41:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] removal of legacy cdrom drivers (Re: [PATCH] mcdx.c insanity removal)
Message-ID: <20040505234140.GC9636@fs.tum.de>
References: <20040502024637.GV17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0405011953140.18014@ppc970.osdl.org> <20040503011629.GY17014@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503011629.GY17014@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 02:16:29AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
>...
> How about removing all that stuff instead of keeping the known broken shit
> in the tree?  If somebody wants it back, they can always pick the versions
> circa 2.6.0 from archives.
> 
> If you are OK with that (and nobody on l-k stands up and claims that they want
> it alive and *claims* *that* *right* *fucking* *NOW*) I'll send you a patch
> putting these buggers out of their misery.

What about marking them as BROKEN in Kconfig and wait how many people 
scream they are still successfully using such drives in 2.6?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

