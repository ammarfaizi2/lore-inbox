Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSHFUKi>; Tue, 6 Aug 2002 16:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSHFUKi>; Tue, 6 Aug 2002 16:10:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:25012 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315458AbSHFUKi>;
	Tue, 6 Aug 2002 16:10:38 -0400
Subject: Re: Linux v2.4.19-rc5
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Cc: Jens Axboe <axboe@suse.de>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFF5AE5098.55777C06-ON85256C0D.006DEB93@pok.ibm.com>
From: "Peter Wong" <wpeter@us.ibm.com>
Date: Tue, 6 Aug 2002 15:12:51 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.10 SPR# MIAS5B3GZN |June
 28, 2002) at 08/06/2002 04:13:00 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Tue, Aug 06 2002, Adrian Bunk wrote:
> > On Tue, 6 Aug 2002, Jens Axboe wrote:
> >
> > >...
> > > try a work load that excercises the block i/o layer alone (O_DIRECT,
> > > raw, whatnot) and then compare 2.4 and 2.5. ibm had some slides on
this
> > > from ols, unfortunately I don't know if they have then online.
> >...
> >
> > Pages 390-406 in
> >
> > http://www.linux.org.uk/~ajh/ols2002_proceedings.pdf.gz
> >
> > or are you talking about something different?

> Right thanks, exactly those. Table 3 on page 395 is the one I noted.
> Forget readv, as that hasn't been done in 2.5 yet. I'd say a 2.5.17
> untweaked kernel beating 2.4 tweaked beyond recognition isn't too shabby
> for a devel series kernel.

The corresponding presentation in the sdd format is available at
      http://www-124.ibm.com/developerworks/opensource/linuxperf/.

Regards,
Peter

Peter Wai Yee Wong
IBM Linux Technology Center, Performance Analysis
email: wpeter@us.ibm.com


