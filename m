Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVF2COc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVF2COc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 22:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVF2CLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 22:11:40 -0400
Received: from web81904.mail.mud.yahoo.com ([68.142.207.183]:48810 "HELO
	web81904.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261164AbVF2CHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 22:07:19 -0400
Message-ID: <20050629020718.8160.qmail@web81904.mail.mud.yahoo.com>
Date: Tue, 28 Jun 2005 19:07:18 -0700 (PDT)
From: Matthew Frost <artusemrys@sbcglobal.net>
Subject: Re: reiser4 plugins
To: Diego Calleja <diegocg@gmail.com>, Hans Reiser <reiser@namesys.com>
Cc: jgarzik@pobox.com, ninja@slaphack.com, alan@lxorguk.ukuu.org.uk,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
In-Reply-To: <20050625164502.7c9745b5.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Diego Calleja <diegocg@gmail.com> wrote:

> El Fri, 24 Jun 2005 21:31:02 -0700,
> Hans Reiser <reiser@namesys.com> escribió:
> 
> 
> > What exactly is not ready Jeff?  As I see it, this thread is 95%
> > posturing, and almost no technical reasons for not merging.  These
> > "authorities"seem perfectly content with echoing the words of someone
> > who skimmed the code and shot his mouth off without understanding it,
> > and now these "authorities" just echo him because they like him and
> > assume he must be right.
> 
> 
> I'm not one of those "authorities" but I doubt reiser4 will be merged
> at all with that attitude.


Spot on.  Somebody hasn't read his Linus.  It seems to me that anytime I
hear whining about how unfair the system is, how arbitrary patch
rejection is, the flaw is either a lack of social competence, or failure
to follow the submission guidelines.  Lately the number three reason,
"Linus forgot," happens less and less.  And linux developers are offering
to help Reiser development fix what's wrong!  That's above and beyond.  

If Hans wants to take his ball and go home, let it be understood that it
is not because of a failure in the linux process.  

People that don't want flames, drop out of flame wars and do constructive
work.  People that want to talk ideology, start flame wars and perpetuate
them.  If you're having a code argument and you can go four posts without
referring to actual code, you're no longer having a code argument. 
Non-demonstrable merit is not merit.  Benchmarks can be necessary -- but
are never alone sufficient -- merit to merge to mainline.

Hans: consider that enough linux people like your stuff enough to have
this argument.  Performance has long since ceased to be at issue.  Linux
is a thing in itself.  If Reiser4 is a thing in itself, and not merely a
means to a further release point, you will care enough about it to merge
it usably and maintainably into the kernel.  Should you obsolesce 4 as
you have done to 3, someone else can care enough about it, and do
something with it.  Features are added to Reiser3 because it is a thing
in itself now that it is in the kernel.  Its users care.  Its
maintainers, even if they still work for Namesys, care.  Listen next time
you hear someone talk about "vendor-abandoned projects" continuing to
function through community development.

Alan has said, "Free software is always late."  Free software follows the
itch.  If Hans wants linux to have Reiser4, Reiser development will work
with linux development to become compliant and explain/adapt any
additional functionality.  Linux does not abjectly need Reiser4 in-tree. 
Reiser4 is ultimately Hans's scratch for Hans's itch.  It will be the
more effective and widely usable once it is stable in-tree, but the
mainline kernel developers aren't the ones with the itch.  Protocols
exist in social systems as a means to constructively enlist the help of
people outside the problem.  The protocols here are well established. 
This is a patch meritocracy.  Failure to comply further increases the
lateness of Reiser4 in mainline kernels.  Ego involvement is noise.

My observations being what they are, may I suggest that this thread die,
in favor of more eyes and in-depth current code analysis help in "Re:
reiser4 merging action list"?  Higher utility function; higher S:N. 
Flames can always go down with the ship.

Frosty
Not a programmer, merely literate.

No, I don't usually respond to trolls, but this thread, from this man,
itches me.  It's not worthy of his brilliance, which may be his tragic
flaw.

