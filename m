Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261930AbTCQUBc>; Mon, 17 Mar 2003 15:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261931AbTCQUBc>; Mon, 17 Mar 2003 15:01:32 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:60171 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261930AbTCQUBc>; Mon, 17 Mar 2003 15:01:32 -0500
Date: Mon, 17 Mar 2003 21:12:10 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Jeff Garzik <jgarzik@pobox.com>
cc: Daniel Phillips <phillips@arcor.de>, Larry McVoy <lm@bitmover.com>,
       Andrea Arcangeli <andrea@suse.de>, Nicolas Pitre <nico@cam.org>,
       Ben Collins <bcollins@debian.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
In-Reply-To: <20030317180432.GD9667@gtf.org>
Message-ID: <Pine.LNX.4.44.0303172031240.5042-100000@serv>
References: <Pine.LNX.4.44.0303161341520.5348-100000@xanadu.home>
 <Pine.LNX.4.44.0303170104080.5042-100000@serv> <20030317013555.GA26273@work.bitmover.com>
 <20030317174304.EC6FC3D268@mx01.nexgo.de> <20030317180432.GD9667@gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Mar 2003, Jeff Garzik wrote:

> > Hence, no more 
> > flaming, just doing.
> 
> Larry seems to be the only one 'doing', ATM.  :)

That's not really true, I posted an example RCS file. I explained how the 
data can be represented in a CVS tree.
The problem is Larry has the tools to easily extract all the data, I 
don't. I offered my help, all Larry has to do is to ask, but it seems he 
prefers to stay in control, which data you will get back.
BTW the data Larry is trying to hide is actually quite simple. The merge 
delta is simply the sum of all deltas from the branch (+ the conflict
fixes you've done), which was merged.

bye, Roman


