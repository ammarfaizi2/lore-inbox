Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281503AbRKMFge>; Tue, 13 Nov 2001 00:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281504AbRKMFgZ>; Tue, 13 Nov 2001 00:36:25 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:54921 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281503AbRKMFgH>; Tue, 13 Nov 2001 00:36:07 -0500
Date: Mon, 12 Nov 2001 22:35:20 -0700
Message-Id: <200111130535.fAD5ZKa18694@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <Pine.GSO.4.21.0111130019340.22925-100000@weyl.math.psu.edu>
In-Reply-To: <200111130503.fAD53ns17951@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0111130019340.22925-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Mon, 12 Nov 2001, Richard Gooch wrote:
> 
> > Alexander Viro writes:
> > > No, you shouldn't.  For those of us who have similar problems with
> > > reviewing your code patch (later - CVS or RCS) will appear on
> > > ftp.math.psu.edu/pub/viro/ tommorrow.  End of story.
> > 
> > So is this the hostile takeover you've mentioned? Even though I'm
> > addressing the devfs races you've complained about so often, and have
> > been releasing these patches, you still wish to pursue this hostile
> > action?
> 
> Oh, for crying out loud!  You've very eloquently described the
> problems with reading code in alien style.  You have said that you
> were tired with other folks complaining about coding style of devfs.
> I replied telling these people where to look for a version that will
> be in standard kernel style, so that they could get off your back.
> What's your problem with _that_, for fsck sake?

Nothing at all, now that you've explained it. If all you want to do is
present the code I write in a form that's more convenient for others
to read, I think that's great.

I thought it might be the "hostile takeover" that you mentioned last
week, along with putting up a CVS tree. If that's not your intention,
that's fine. That's why I asked "is this the hostile takeover you've
mentioned", because I wasn't sure.

In fact, given the other code in the tree that doesn't conform to
CodingStyle, it makes sense run lindent on the whole tree and make
that available. As long as people understand that they should generate
patches against the real tree, and not the lindented one.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
