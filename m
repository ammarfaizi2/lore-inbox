Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263198AbSJGUuS>; Mon, 7 Oct 2002 16:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263195AbSJGUtY>; Mon, 7 Oct 2002 16:49:24 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:55172
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S263194AbSJGUtT>; Mon, 7 Oct 2002 16:49:19 -0400
Date: Mon, 7 Oct 2002 16:54:47 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Pavel Machek <pavel@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ulrich Drepper <drepper@redhat.com>,
       Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
In-Reply-To: <20021007203714.GC7428@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44.0210071646170.913-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, Pavel Machek wrote:

> Hi!
> 
> 
> > > > If BK migrates to proprietary format everybody will notice and you'll still
> > > > have the opportunity to rescue a not too old repository and carry on with
> > > > life using whatever alternate SCM you wish.  If such a thing happened Lary
> > > > would be publicly and universally discredited and he's not looking for that
> > > > I'm sure.
> > > 
> > > If BK migrates to a proprietary format the code won't be in the
> > > preferred form of the work for making modifications.
> > 
> > Because you think BK will still have the backing of all kernel developers
> > using it today if that happens?  Some might find BK's nice to use despite its
> > license, but locking the main kernel repository into a proprietary format is
> > totally unacceptable for most if not all of them I'm sure.  
> 
> Of course Larry would have to do the changes "slowly" so people would
> not notice. And every time someone complains he can repeat his "I'm
> running business".

At which point he'll piss of more and more kernel developers and lose them
"slowly" as well, unless Linus himself gets pissed at which point the kernel
user base will disappear in a single glitch.  Breaking SCCS compatibility
"slowly" without anybody noticing before it's too late is a bit far fetched
IMHO.

Anyway this whole story boils down to the New Conspiracy Theory:

      "The world wants to screw Larry vs Larry wants to screw the world"


Nicolas

