Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264958AbSKANzX>; Fri, 1 Nov 2002 08:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265015AbSKANzW>; Fri, 1 Nov 2002 08:55:22 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:51972 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S264958AbSKANzU>; Fri, 1 Nov 2002 08:55:20 -0500
Date: Fri, 1 Nov 2002 09:03:20 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: linux-kernel@vger.kernel.org, <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0211010013490.3873-100000@svr.cih.com>
Message-ID: <Pine.LNX.4.44.0211010853310.10880-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002, Craig I. Hagan wrote:

> > Talk is cheap.
> >
> > I've not seen a _single_ bug-report with a fix that attributed the
> > existing LKCD patches. I might be more impressed if I had.
> >
> > The basic issue is that we don't put patches in in the hope that they will
> > prove themselves later. Your argument is fundamentally flawed.
>
> comment from userspace:
>
> I'm going to have to side with Linus here despite my desire to see LKCD
> merged.

I'll have to disagree with what you're saying, because:

> However, we need to show him the money. This means:
>
> 	* making sure that the patches are kept up to date

They are being kept up to date, and aparently have been for some time.

> 	* keep the LKCD patches in the list/community spotlight in a positive
> 		manner ("please test this!", or  "please use this when
> 		looking for help debugging a system problem"). Perhaps
> 		a 2.5.x-lkcd bk tree or something like that.

Umm, and the difference between maintaining a set of patches per kernel
version and something using bitkeeper (or heaven forbid, CVS)?  Even
Linus didn't starting using source code management until somewhat
recently.

> 	* make documentation/HOWTO's available for folks so that
> 		they'll know how to generate a crashdump
> 		and run a some utilities against it to generate
> 		a synopsis which can be submitted for debugging

Have you seen http://lkcd.sf.net ?  They have that there.   I've
successfully walked through their well-written tutorials and produced
crashdumps from machines that have failed.

> 	* most important: squash a whole lot of bugs with
> 		said dumps!

Perhaps people are but they're not posting the bugs to the list...

> If it becomes apparent through empirical data that crash dumps are a useful
> tool, I'm sure that Linus will become far more amenable. Until then, lets let
> him handle all of his other work which needs to get done.

The data is there, perhaps not for Linux, but for other Unixes -
including ones like the BSDs.  Crashdumps are an invaluable resource for
finding bugs that involve things like hardware that doesn't conform
exactly to specs, or deadlocks, or...

Pat
--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu

http://dilbert.com/comics/dilbert/archive/images/dilbert2040637020924.gif



