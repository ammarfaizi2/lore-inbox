Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261777AbTCQV5g>; Mon, 17 Mar 2003 16:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261910AbTCQV5g>; Mon, 17 Mar 2003 16:57:36 -0500
Received: from mail-8.tiscali.it ([195.130.225.154]:26057 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S261777AbTCQV5g>;
	Mon, 17 Mar 2003 16:57:36 -0500
Date: Mon, 17 Mar 2003 23:08:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Roman Zippel <zippel@linux-m68k.org>, Nicolas Pitre <nico@cam.org>,
       Ben Collins <bcollins@debian.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030317220830.GM1324@dualathlon.random>
References: <Pine.LNX.4.44.0303161341520.5348-100000@xanadu.home> <Pine.LNX.4.44.0303162014090.12110-100000@serv> <20030316215219.GX1252@dualathlon.random> <20030317215639.GG15658@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030317215639.GG15658@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 10:56:39PM +0100, Pavel Machek wrote:
> Hi!
> 
> > If you're still unhappy now that the mainline data is open it means
> > you're either a jfs developer (but I assume they're all fine with bk
> > since they're just using it, so I doubt this is the case) or your
> 
> Actually, fact that "longest path" algorithm may well choose
> non-mainline branch because it likes it more worries me a bit.

AFIK it's supposed to be the "longest path" of Linus's and Marcelo's
branches which means it'll reproduce all the modifcations of the
mainline trees only.

Andrea
