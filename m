Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268092AbTAIXhP>; Thu, 9 Jan 2003 18:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268096AbTAIXhP>; Thu, 9 Jan 2003 18:37:15 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:62994 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S268092AbTAIXhN>; Thu, 9 Jan 2003 18:37:13 -0500
Date: Fri, 10 Jan 2003 00:45:51 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Nvidia and its choice to read the GPL "differently"
Message-ID: <20030109234551.GB31310@merlin.emma.line.org>
Reply-To: matthias.andree@gmx.de
Mail-Followup-To: matthias.andree@gmx.de
References: <fa.gm4r3cv.1r4avpq@ifi.uio.no> <fa.hq6mucv.l4qg1c@ifi.uio.no> <3E1C3D87.7030605@debian.org> <E18Wlrc-0000Ph-00@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E18Wlrc-0000Ph-00@fencepost.gnu.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Jan 2003, Richard Stallman wrote:

> Calling the system "Linux" denies the GNU Project credit for the GNU
> operating system.  Most of the people who do that still give us credit
> for the specific programs we developed.  These words
> 
>     GNU is not so important in new system. I take gcc and glibc as to be
>     outside the GNU project.
> 
> take a further step: they deny the GNU Project the credit even for GNU
> programs (he said, earlier, this is on the grounds that companies have
> contributed to them).  That's like denying Linus Torvalds the credit
> for writing the kernel, Linux, because companies have helped that too.

Richard, some people are going to offer this "GNU/" attribution, some
won't. I belong to the latter group although I recognize what the GNU
project has achieved so far. It's a fairness issue, as has been pointed
out. If we need to credit, then we need to credit every major
contributor, and that's, as has been pointed out, a term that's pretty
unusable to name that thing. You want Linux to subordinate under GNU?
Fine. What sold GNU to the masses? Linux. They're friends. Still, you
don't make friends change their names. Now finish that thread.

> Has anyone been so completely warped by hatred of GNU?  I don't know,
> but it does not really matter.  The role of GCC in the development and
> popularity of GNU/Linux is a fact of history, and subsequent
> developments cannot change it.

There is not hatred of GNU. There is alienation by your horrible waste
of time and energy. This is the wrong forum, this is only full of people
who make ONE SINGLE component of what YOU want to be named GNU/Linux.
You're about to get GNU credited but neglect all the other major
contributors, XFree86 has been named, BSD is one.

GNU code borrows interfaces from Solaris (and then does it wrong, for
example the GNU libc name service switch is broken in that it does not
retry NIS queries and then reports temporary errors through interfaces
that cannot return temporary conditions such as getpwnam -- no way to
place TRYAGAIN=forever into /etc/nsswitch.conf with GNU glibc, but
required for reliable operation and possible to configure on Solaris). I
ask you to rename all occurrences of Name Service Switch to Sun
Microsystems Solaris Name Service Switch.  Add [tm] and ® symbols as
appropriate. Solaris gave you the ideas of NSS. So credit Sun.

And now get this bloody discussion off-list.

-- 
Matthias Andree
