Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262583AbSJGTBN>; Mon, 7 Oct 2002 15:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262584AbSJGTBN>; Mon, 7 Oct 2002 15:01:13 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:17540
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S262583AbSJGTBK>; Mon, 7 Oct 2002 15:01:10 -0400
Date: Mon, 7 Oct 2002 15:06:38 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Pavel Machek <pavel@suse.cz>
cc: Ulrich Drepper <drepper@redhat.com>, Larry McVoy <lm@bitmover.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
In-Reply-To: <20021007011512.B6352@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0210071451150.913-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, Pavel Machek wrote:

> > You can do this today.  rsync a BK tree and use GNU CSSC to check out
> > the sources.  We maintained SCCS compat for exactly that reason.
> > You've had the ability to ignore the BKL since day one if you aren't
> > running the BK binaries.
> 
> Would someone write nice HOWTO do this?
> 
> And where's guarantee that you are not migrating BK to proprietary
> format to cut this off once someone writes the HOWTO?

Please stop the paranoia and have faith.  Where's guarantee you won't be hit 
by a bus today?

If BK migrates to proprietary format everybody will notice and you'll still
have the opportunity to rescue a not too old repository and carry on with
life using whatever alternate SCM you wish.  If such a thing happened Lary
would be publicly and universally discredited and he's not looking for that
I'm sure.


Nicolas

