Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285183AbRLRV2Q>; Tue, 18 Dec 2001 16:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285180AbRLRV1F>; Tue, 18 Dec 2001 16:27:05 -0500
Received: from [213.236.192.200] ([213.236.192.200]:6666 "EHLO
	mail.circlestorm.org") by vger.kernel.org with ESMTP
	id <S285184AbRLRV0l>; Tue, 18 Dec 2001 16:26:41 -0500
Message-ID: <005701c1880a$05175430$6c2876d9@dead2>
From: "Dead2" <dead2@circlestorm.org>
To: "Ken Brownfield" <brownfld@irridia.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E16GLmv-0007d4-00@the-village.bc.nu> <026701c187d5$ec2472c0$67c0ecd5@dead2> <20011218123724.A32316@asooo.flowerfire.com>
Subject: Re: The direction linux is taking (CVS)
Date: Tue, 18 Dec 2001 22:21:55 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Ken Brownfield" <brownfld@irridia.com>

> The CVS tree availability you mention parallels the FreeBSD tree, I
> believe.  However, assuming enough brain cycles, one knowledgable
> maintainer seems to be a better method of maintaining a kernel.

Then positive and negative sides should be gathered from their experiences
aswell, it can be good for the outcome to follow something that has
been tested thoroughly by others.

*snip*

> I've been following lkml for some time now, and I've been using patches
> that get posted to the list.  But I do so at my own risk, since I do not
> have comprehensive knowledge of kernel internels.  But even I can tell
> that many of the patches posted are either bogus, are potentially
> incorrect in subtle and/or complex ways, or are simply working around
> user-space issues or other bugs.

Therfore only trusted maintainers should have access. Normal deadly
people like me would have to contact the maintainer(s) for that sub-tree.

> What might take out a few birds with one stone is to have someone on
> lkml become an "LKML MAINTAINER": collect patches and bug reports in a
> central place.  This would include:
>
> 1) The patch and/or bug report
> 2) The entire LKML thread, with "important" messages marked
> 3) Personal input, prioritization, severity info, etc.

Or even make a kernel-patches@vger.kernel.org address that would be
parsed manually of automaticly..

*snip-snip*
> --
> Ken.
> brownfld@irridia.com

-=Dead2=-

> On Tue, Dec 18, 2001 at 04:09:00PM +0100, Dead2 wrote:
> | > > > 1. Are we satisfied with the source code control system ?
> | > >
> | > > Yes.  Alan (2.2) and Marcelo (2.4) and Linus (2.5) are doing
> | > > a good job with source control.
> | >
> | > Not really. We do a passable job. Stuff gets dropped, lost,
> | > deferred and forgotten, applied when it conflicts with other work
> | > - much of this stuff that software wouldnt actually improve on over a
> | > person
> |
> | What about having the Linux source code in a CVS tree where active/trusted
> | driver-/module-maintainers are granted write access, and everyone else read
> | access.
> | After the patches are applied, people will test them out, and bugfixes will
> | be applied when bugs are detected.
> | Then, when the kernel-maintainer feels this or that sourcecode is ready for
a
> | .pre kernel, he puts it in the main kernel tree.
> | (This would indeed pose a security risk, but who in their right mind would
run
> |  a CVS snapshot on anything important, that's right _noone_ in their _right
> | mind_)
> |
> | Of course this would require much maintenance, and possibly more than
> | one kernel-maintainer. This because of how much easier it would become
> | for driver-/module-maintainers to apply patches they believe would make
> | things better. Cleanups would also be necessary from time to time..
> | (cleanups = making the CVS identical to the main kernel tree again)
> |
> | Just my 2 cents..
> |
> | -=Dead2=-
> |
> |
> |
> |
> | -
> | To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> | the body of a message to majordomo@vger.kernel.org
> | More majordomo info at  http://vger.kernel.org/majordomo-info.html
> | Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


