Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282151AbRKWONU>; Fri, 23 Nov 2001 09:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282153AbRKWONK>; Fri, 23 Nov 2001 09:13:10 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:8898 "EHLO
	c0mailgw02.prontomail.com") by vger.kernel.org with ESMTP
	id <S282151AbRKWOMz>; Fri, 23 Nov 2001 09:12:55 -0500
Message-ID: <3BFE591B.D1F75CD5@starband.net>
Date: Fri, 23 Nov 2001 09:11:39 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: Which gcc version?
In-Reply-To: <20011123125137Z282133-17408+17815@vger.kernel.org> <5.1.0.14.2.20011123135801.00aad970@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#1) The compiler from redhat (gcc-2.96) is not an official GNU release.
#2) http://www.atnf.csiro.au/~rgooch/linux/docs/kernel-newsflash.html/
      "the reccomend compiler is now gcc-2.95.3, rather than gcc-2.91.66"


Anton Altaparmakov wrote:

> At 13:51 23/11/01, war wrote:
> >You should use gcc-2.95.3.
>
> That's not true. gcc-2.96 as provided with RedHat 7.2 is perfectly fine.
>
> gcc-3x OTOH is not a good idea at the moment.
>
> Anton
>
> >Roy Sigurd Karlsbakk wrote:
> >
> > > hi all
> > >
> > > I just wonder...
> > > With a clean rh72 install, I've got two gcc versions installed in parllel,
> > > 2.96 and 3.0.2. Which one should I use to compile the kernel?
> > >
> > > thanks
> > >
> > > roy
> > > --
> > > Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA
> > >
> > > Computers are like air conditioners.
> > > They stop working when you open Windows.
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
>
> --
>    "I've not lost my mind. It's backed up on tape somewhere." - Unknown
> --
> Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
> Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
> ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

