Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267735AbTATBvH>; Sun, 19 Jan 2003 20:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267737AbTATBvH>; Sun, 19 Jan 2003 20:51:07 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:27568 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S267735AbTATBvF>; Sun, 19 Jan 2003 20:51:05 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Valdis.Kletnieks@vt.edu
Cc: David Schwartz <davids@webmaster.com>, adilger@clusterfs.com,
       Roman Zippel <zippel@linux-m68k.org>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Date: Sun, 19 Jan 2003 17:46:54 -0800 (PST)
Subject: Re: Is the BitKeeper network protocol documented? 
In-Reply-To: <200301200036.h0K0aCIJ012273@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.44.0301191741550.6293-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0301191741552.6293@dlang.diginsite.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

don't forget that sourceforge itself is not GPL so are people saying that
all projects in sourceforge can't be GPL?

think people, do you really want to go there?

goeing even further, if the source for a GPL program is stored on a
non-GPL filesystem does that conflict with the license of the filesystem?
does that meant that if I load the linux kernel source on a Veritos
filesystem and decid that that's the 'prefered' form of the source code
that veritos is forced to GPL their software?

not even RMS is supporting a position like this so apply a LITTLE sense
here, PLEASE.

David Lang

On Sun, 19 Jan 2003 Valdis.Kletnieks@vt.edu wrote:

> Date: Sun, 19 Jan 2003 16:36:12 -0800
> From: Valdis.Kletnieks@vt.edu
> To: David Schwartz <davids@webmaster.com>
> Cc: adilger@clusterfs.com, Roman Zippel <zippel@linux-m68k.org>,
>      Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
> Subject: Re: Is the BitKeeper network protocol documented?
>
> On Sun, 19 Jan 2003 15:57:40 PST, David Schwartz said:
>
> > 	I think you're ignoring the way the GPL defines the "source
> code".
> > The GPL defines the "source code" as the preferred form for modifying
> > the program. If the preferred form of a work for purposes of
> > modifying it is live access to a BK repository, then that's the
> > "source code" for GPL purposes.
>
> Dammit, *MY* preferred form might be CVS, I want a CVS tree instead!!
>
> I can't use BitKeeper based on my reading of the license and Larry's
> comments, because one of my current projects is a system-config
> versioning
> and tracking system. (Hey Larry et al - thanks for a good tool and
> getting Linus
> to use it.. ;)
>
> Just because Linus happens to be using BK currently does *NOT*
> automagically
> make it the industry-standard preferred format.
>
> Not everybody has BitKeeper - as such, a .tar.gz of the source tree can
> reasonably be considered the "preferred" form if your intent is to make
> the tree available to as many people as possible - if it's a .tar.gz,
> the
> only thing you need is a GNU-compatible tar command to extract it.
> Certainly
> preferable to BK if you want somebody to be able to get going with as
> little
> as possible.
>
> And let's go look at another clause there:
>
> > 1. You may copy and distribute verbatim copies of the Program's
> > source code as you receive it,
>
> Does this mean that Linus can't distribute a tree with patches
> integrated, but
> has to include copies of things as they were posted to LKML?
>
> Actually, you *want* Linus to be editing, so he has copyright on the
> collection as a whole (very important, as another poster commented).
>
> Moral: Let's not get silly here...
>
> > making modifications to it.  For an executable work, complete source
> > code means all the source code for all modules it contains, plus any
> > associated interface definition files, plus the scripts used to
> > control compilation and installation of the executable.
>
> Hmm.. and what is Linus failing to ship here?  The .c files are in
> there,
> the .h files are in there, the Kconfig/Makefiles are there....
>
> Note that this clause doesn't even apply unless you distribute
> *binaries*.
> Linus doesn't do that, RedHat does that - and THEIR preferred format for
> distributing is a .RPM.  Ever tried to figure out what RedHat did to
> something
> when you're on a machine without RPM?   Yep, you get to track down
> rpm2cpio or
> similar...
>
> I'll make the only-slightly facetious comment that the *preferred*
> format
> for a kernel tree would include a neuron dump of the people who were
> doing
> the coding, so we would be able to determine whether a given change was
> truly enlightened and correct, or if they were just on crack at the
> time....
> --
> 				Valdis Kletnieks
> 				Computer Systems Senior Engineer
> 				Virginia Tech
>
>
