Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130460AbRBGT6n>; Wed, 7 Feb 2001 14:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130476AbRBGT6d>; Wed, 7 Feb 2001 14:58:33 -0500
Received: from larnyx.timpanogas.net ([207.109.151.235]:16903 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130460AbRBGT6S>; Wed, 7 Feb 2001 14:58:18 -0500
Message-ID: <3A81A789.3F73FAA7@timpanogas.com>
Date: Wed, 07 Feb 2001 12:52:41 -0700
From: Larry <langus@timpanogas.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18-27 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: langus@timpanogas.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: PCI-SCI Build Problems on RedHat 7.1
In-Reply-To: <20010207131439.A28015@vger.timpanogas.org> <E14QaAX-00016d-00@the-village.bc.nu> <20010207132426.A28159@vger.timpanogas.org> <20010207133515.A28268@vger.timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry Angus wrote:
This is the RedHat "fisher" beta,  version 7.0.90 available from RedHat
the Kernel is:  version 2.4.0-0.99.11
gcc is:  version 2.96  release 71 (which came with fisher)
make is:   version 3.79.1  release 5   (came with fisher)
glibc is:   version 2.2.1  release 3   (also came with fisher)
for further info:
langus@timpanogas.com



"Jeff V. Merkey" wrote:

> On Wed, Feb 07, 2001 at 01:24:26PM -0700, Jeff V. Merkey wrote:
>
> Larry,
>
> Please provide to Alan Cox the exact versions and revision levels of
> the RedHat 7.1 build used for the SCI testing.  Please provide him
> any other information he requests concerning the setup of this
> system.
>
> Jeff
>
> > On Wed, Feb 07, 2001 at 07:22:19PM +0000, Alan Cox wrote:
> > > > In file included from init.c:30:
> > > > ../../prolog.h:344:8: invalid #ident
> > >
> > > It doesnt say #ident isnt supported it says your use of it is invalid. What
> > > precisely does that line read ?
> >
> > JJ tried it and it worked on some version he was running, but fails on
> > the 7.1 build.  Here is the code that produces the offending messages.
> > I got an "invalid keyword" (sorry, it was not "unknown" but "invalid", that was
> > a different error message on gcc 2.96).
> >
> > Jeff
> >
> >

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
