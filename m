Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbTLBSel (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264327AbTLBSel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:34:41 -0500
Received: from thor.goeci.com ([66.28.220.99]:42766 "EHLO THOR.goeci.com")
	by vger.kernel.org with ESMTP id S264325AbTLBSef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:34:35 -0500
Message-ID: <2D92FEBFD3BE1346A6C397223A8DD3FC0924CA@THOR.goeci.com>
From: Murthy Kambhampaty <murthy.kambhampaty@goeci.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>,
       Murthy Kambhampaty <murthy.kambhampaty@goeci.com>
Cc: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       Russell Cattelan <cattelan@xfs.org>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Andrew Morton <akpm@osdl.org>
Subject: RE: XFS for 2.4
Date: Tue, 2 Dec 2003 13:34:34 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, December 02, 2003 1:00 PM, Jeff Garzik
[mailto:jgarzik@pobox.com] wrote:

> On Tue, Dec 02, 2003 at 12:45:38PM -0500, Murthy Kambhampaty wrote:
> > i) Would the linux 2.4 kernel maintainer please stop 
> trolling the XFS
> > mailing list.
> 
> Ok, we'll avoid discussing a major point in XFS's life -- potentially
> being merged into 2.4 -- on XFS list.  Makes sense.

I don't see what "discussion" is promoted by Marcelo' comment at this stage
in the game that he doesn't like the style of the XFS code, and hasn't for a
while, without any constructive examples of what he'd like changed. I'm not
sure how you got the impression that my point was that Marcelo shouldn't
post his decision not to include XFS in 2.4 to the kernel? Sorry.


> 
> 
> > iii) The 2.4 series kernel is the here and now, regardless 
> of how near we
> > all hope/project the 2.6 kernel to be (has Andrew Morton 
> even taken it over
> > from Linus?). Pushing 2.6 on users, and unjustifiably 
> blocking the adoption
> > of advanced features into the current linux kernel is 
> pretty absurd. XFS has
> 
> This is bogus logic.
> 
> Nobody is forcing 2.6 on anyone.  People who wish to use XFS in 2.4
> _can do so today_...  without any merging from Marcelo.
> 
> Merging is nothing more than moving a patch from one place to another.

One of the reasons Marcelo gives for not including XFS in 2.4 is that 2.6 is
nearly here and it includes XFS (feel free to review his posts on the
subject). My point is that that is bogus logic. Not to put too fine a point
on it, but moving a patch from one place to another is the kernel
maintainer's job. 


> 
> 
> > If you can't come up with something more concrete than "I 
> don't like your
> > coding style" and "I'm not sure your patch won't break 
> something", it seems
> > only fair you take the XFS patches.
> 
> This is bogus logic.
> 
> It's _very_ wise to hold off on a patch if
> (a) the code is difficult to read, and therefore difficult to 
> review and
>     fix (read: style)
> (b) the maintainer is not assured of patch reliability (read: "I'm not
>     sure the patch won't break things")
> 
> Both (a) and (b) are vaild concerns for long term maintenance costs.
> 
> Particularly (b).  If Marcelo is not assured of patch 
> reliability, then
> he absolutely --should not-- merge XFS into 2.4.  That's just the way
> the system works.  And it's a good system.

I agree with the logic you present here, and which Larry McVoy similar
comments. My point is that XFS has gone through this mill (and Christoph
Hellwig's opinion counts infinitely more than mine on this question). The
suggestion that "the maintainer is not assured of patch reliability" with
respect to XFS seems cooked-up. 

In the final analysis, if what it takes is for a filesystem maintainer to
jump up and down screaming for XFS's inclusion, then I'm no help ...
