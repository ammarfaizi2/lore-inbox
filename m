Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314708AbSDVTvn>; Mon, 22 Apr 2002 15:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314710AbSDVTvn>; Mon, 22 Apr 2002 15:51:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53921 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314708AbSDVTvk>;
	Mon, 22 Apr 2002 15:51:40 -0400
Date: Mon, 22 Apr 2002 15:51:39 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Jonathan A. George" <JGeorge@greshamstorage.com>
cc: Jeff Garzik <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <3CC46231.8080008@greshamstorage.com>
Message-ID: <Pine.GSO.4.21.0204221528550.5554-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Apr 2002, Jonathan A. George wrote:

> Not quite.  Linus uses BK as a tool to facilitate kernel development. 
>  However, he has not made BK _part_ _of_ _the_ _kernel_. ;-)  Obviously 
> anyone can use any tool ON the kernel, but integrating into the kernel 
> is something else.
> 
> >Talk Linus out of using BitKeeper, and sure, I'll remove the doc.
> >
> No need.  His tools are his choice.  The kernel itself is ours not his; 
>  thus the distinction.

Bullshit.  His copy is his.  Mine is mine.  Yours is yours.  Each of
us is perfectly within his rights when he adds whatever patches he
likes.

And that's _it_.  Linus has absolute control over his copy, as long
as he doesn't run afoul of copyright restrictions.  So do I.  So do
you.  GPL explicitly allows to modify and redistribute result of
modifications.  As the matter of fact, as soon as you attempt to
limit such right, you are losing all rights granted to you by GPL.

"Official" tree is the copy placed by Linus on ftp.kernel.org.  And
as long as ftp.kernel.org admins keep his account (and write permissions
on directory in question) that copy is controlled by Linus.  Period.
End of story.  Linus has exactly the same rights as anybody else and
_everyone_ has a right to modify his copy as he likes.

If you don't like it - take it with RMS and FSF, who happen to feel
very strongly about that right.  That's what GPL is about.  If you
don't like modifications done by somebody, you have only one 
recourse - you are allowed to back them off _in_ _your_ _copy_
and distribute that copy.

It's fscking amazing that self-proclaimed GPL advocates happily
ignore the main stated goal of GPL - to ensure that everybody will be
able to hack on his copy as he wants and share results with
everybody else.  The fact that your modifications are in there
does not allow you to stop anybody else from further modifications.

