Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbTBORes>; Sat, 15 Feb 2003 12:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbTBORes>; Sat, 15 Feb 2003 12:34:48 -0500
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:17345
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S263137AbTBORer>; Sat, 15 Feb 2003 12:34:47 -0500
Date: Sat, 15 Feb 2003 12:44:34 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Larry McVoy <lm@bitmover.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: openbkweb-0.0
In-Reply-To: <20030214235724.GA24139@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0302151207390.13273-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2003, Larry McVoy wrote:

> As with many things in life, you can choose to behave well or poorly and
> the people you help or hurt will act according.

Larry,

Aren't you tired of all this shit people are making of BK?

You will always have people bitching at you just like people are bitching at
Microsoft Word, whether those people are morons or great hackers is
irrelevant.

Be smart and put a Linux CVS repository on bkbits.net even if it costs you
some bandwidth money at first, oh and have the CVS repo to be always in sync
with the bk repo of course.  This way you'll be able to tune the process,
make sure it can be fully automated, then everybody will be happy and you'll
sleep in peace for a while.

Then, to handle the bandwidth/money issue, you just need to put bandwidth
limiting on the CVS port (Linux can do that so well - just ask for help if
you can't achieve it) and issue a call for mirror sites where bkbits.net
could commit CVS changes to.  Right now BitKeeper might have solved the
Linux development process scalability issue (from the community toward
Linus), but for the process to be perfect you also need to address the
opposite path i.e. the broadcasting of changes that Linus applied toward
the community, and this has to happen in real time as well.

We can agree that BitKeeper is so superior to CVS just like M$ Word format
is way more powerful than plain text [1].  The reality is that plain text
files are just so portable and universally readable that they are preferable
to the Word format, even if M$ is giving Word viewers away for free.

You can't change the Free Software world that you are so faithfully trying
to help.  You still can make them happy, and for that a real-time gateway
from the Linux bk to CVS repos is the only way for the present time.  CVS is
still the lowest common denominator SCM among this world and you can't 
ignore it for broadcasting changes back to the community.


Nicolas


[1] this doesn't mean that I personally endorse M$ Word in any way.

