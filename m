Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262546AbTCIRLF>; Sun, 9 Mar 2003 12:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262547AbTCIRLF>; Sun, 9 Mar 2003 12:11:05 -0500
Received: from dsl081-067-005.sfo1.dsl.speakeasy.net ([64.81.67.5]:17806 "EHLO
	renegade") by vger.kernel.org with ESMTP id <S262546AbTCIRLA>;
	Sun, 9 Mar 2003 12:11:00 -0500
Date: Sun, 9 Mar 2003 09:20:45 -0800
From: Zack Brown <zbrown@tumblerings.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <20030309172045.GP4170@renegade>
References: <m14r6ck6jd.fsf@frodo.biederman.org> <Pine.LNX.4.44.0303091609440.5042-100000@serv> <8200000.1047228943@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8200000.1047228943@[10.10.2.4]>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 09, 2003 at 08:55:44AM -0800, Martin J. Bligh wrote:
> I think it's possible to get 90% of the functionality that most of us
> (or at least I) want without the distributed stuff. If that's 10% of
> the effort, would be really nice to have the auto-merging type of
> functionality at least.

> If I'm missing something fundamental here, it wouldn't suprise me ;-)

I think the fundamental thing you're missing is that Linus doesn't want it. ;-)

As long as people keep trying to avoid the hard problems that Linus and Larry
keep pointing out, I doubt any effort will get very far. I see a lot of cases
where someone says, "yeah, but we can side-step that problem if we do x,
y, or z." That doesn't help. The question is, what are the actual features
required for a version control system that could win support among the top
kernel developers?

People in the know hint at these features ("naming is really important"),
but the details are apparently complicated enough that no one wants to sit
down and actually describe them. They just hint at the *sort* of problems
they are, and then someone says, "but that's not really a problem because
of x, y, or z that can be done instead."

Then people get sidetracked on the features they personally would settle for,
and the real point gets lost in the fog. Or else they start dreaming
about what the perfect system would be like, describing features that
would not actually be required for a kernel-ready version control
system.

Unless the people in the know actually speak up, the rest of us just won't
be able to figure out what they need. A lot of projects are chasing their
tails right now, trying to do something, but lacking the direction they need
in order to do it.

Be well,
Zack

> 
> M.

-- 
Zack Brown
