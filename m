Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTLBSDU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTLBSDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:03:19 -0500
Received: from havoc.gtf.org ([63.247.75.124]:34195 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262566AbTLBSDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:03:14 -0500
Date: Tue, 2 Dec 2003 12:59:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Murthy Kambhampaty <murthy.kambhampaty@goeci.com>
Cc: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       Russell Cattelan <cattelan@xfs.org>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: XFS for 2.4
Message-ID: <20031202175957.GA1990@gtf.org>
References: <2D92FEBFD3BE1346A6C397223A8DD3FC0924C8@THOR.goeci.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2D92FEBFD3BE1346A6C397223A8DD3FC0924C8@THOR.goeci.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 12:45:38PM -0500, Murthy Kambhampaty wrote:
> i) Would the linux 2.4 kernel maintainer please stop trolling the XFS
> mailing list.

Ok, we'll avoid discussing a major point in XFS's life -- potentially
being merged into 2.4 -- on XFS list.  Makes sense.


> iii) The 2.4 series kernel is the here and now, regardless of how near we
> all hope/project the 2.6 kernel to be (has Andrew Morton even taken it over
> from Linus?). Pushing 2.6 on users, and unjustifiably blocking the adoption
> of advanced features into the current linux kernel is pretty absurd. XFS has

This is bogus logic.

Nobody is forcing 2.6 on anyone.  People who wish to use XFS in 2.4
_can do so today_...  without any merging from Marcelo.

Merging is nothing more than moving a patch from one place to another.


> If you can't come up with something more concrete than "I don't like your
> coding style" and "I'm not sure your patch won't break something", it seems
> only fair you take the XFS patches.

This is bogus logic.

It's _very_ wise to hold off on a patch if
(a) the code is difficult to read, and therefore difficult to review and
    fix (read: style)
(b) the maintainer is not assured of patch reliability (read: "I'm not
    sure the patch won't break things")

Both (a) and (b) are vaild concerns for long term maintenance costs.

Particularly (b).  If Marcelo is not assured of patch reliability, then
he absolutely --should not-- merge XFS into 2.4.  That's just the way
the system works.  And it's a good system.

	Jeff



