Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262632AbTCIVXF>; Sun, 9 Mar 2003 16:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262634AbTCIVXF>; Sun, 9 Mar 2003 16:23:05 -0500
Received: from dsl081-067-005.sfo1.dsl.speakeasy.net ([64.81.67.5]:64399 "EHLO
	renegade") by vger.kernel.org with ESMTP id <S262632AbTCIVXE>;
	Sun, 9 Mar 2003 16:23:04 -0500
Date: Sun, 9 Mar 2003 13:32:46 -0800
From: Zack Brown <zbrown@tumblerings.org>
To: Larry McVoy <lm@work.bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030309213246.GC25121@renegade>
References: <m14r6ck6jd.fsf@frodo.biederman.org> <Pine.LNX.4.44.0303091609440.5042-100000@serv> <8200000.1047228943@[10.10.2.4]> <20030309172045.GP4170@renegade> <20030309195852.GA6647@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030309195852.GA6647@work.bitmover.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 11:58:52AM -0800, Larry McVoy wrote:
> On Sun, Mar 09, 2003 at 09:20:45AM -0800, Zack Brown wrote:
> > People in the know hint at these features ("naming is really important"),
> > but the details are apparently complicated enough that no one wants to sit
> > down and actually describe them. 
> 
> It's perfectly OK for you to go invent a new SCM system.  Go for it.
> But stop asking for help from the BK crowd.

I haven't been asking you for help. I've been asking Linus and other
kernel developers to describe their needs. There seems to be three
camps in this discussion:

1) the people who feel that the hard problems solved by BitKeeper are
crucial

2) the people who feel that the hard problems are not that important,
and that a decent feature set could be designed to handle pretty much
everything anyone might normally need

3) the people who want features that are not really related to finding a
BitKeeper alternative.

My own opinion is that the people in camp (2) are falling into the trap which
has been described often enough, in which they will realize their design
mistakes too late to do anything about them. Whil the people in camp (3)
seem to be getting ahead of the game. The features they want are all great,
but the question of the basic structure still remains.

I think what needs to be done is to identify the hard problems, so that
any version control project that starts up can avoid mistakes that will
put a glass ceiling over their heads. Even if they choose not to implement
everything, or if they choose to implement features orthogonal to a real
BitKeeper alternative, they would still have the proper framework to raise
the project to the highest level later.

Of kernel developers, only Linus seems to have a clear idea of what the kernel
development process' needs are; but aside from insisting that distribution
is key (which people in camp (1) know already), he hasn't gone into the kind
of detail that folks would need in order to actually make a decent attempt.

Be well,
Zack

-- 
Zack Brown
