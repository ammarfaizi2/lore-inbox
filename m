Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbTDBHEQ>; Wed, 2 Apr 2003 02:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261860AbTDBHEQ>; Wed, 2 Apr 2003 02:04:16 -0500
Received: from port-213-148-149-130.reverse.qsc.de ([213.148.149.130]:10689
	"EHLO eumucln02.mscsoftware.com") by vger.kernel.org with ESMTP
	id <S261857AbTDBHEO>; Wed, 2 Apr 2003 02:04:14 -0500
In-Reply-To: <3E89F52F.3090802@rackable.com>
Subject: Re: File system corruption under 2.4.21-pre5-ac1
To: Samuel Flory <sflory@rackable.com>
Cc: gibbs@scsiguy.com, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OF24FBD726.9F07DE25-ONC1256CFC.00278BDA-C1256CFC.0027C68B@mscsoftware.com>
From: Martin.Knoblauch@mscsoftware.com
Date: Wed, 2 Apr 2003 09:14:27 +0200
X-MIMETrack: Serialize by Router on EUMUCLN02/MSCsoftware(Release 5.0.10 |March 22, 2002) at
 04/02/2003 09:05:13 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Samuel Flory <sflory@rackable.com> wrote on 04/01/2003 10:23:11 PM:

> Martin Knoblauch wrote:
>
> >>Re: File system corruption under 2.4.21-pre5-ac1
> >>
> >>From: Justin T. Gibbs (gibbs@scsiguy.com)
> >>Date: Mon Mar 31 2003 - 14:26:27 EST
> >>
> >>
> >>
> >>
> >>>I'm seeing filesystem corruption on a number of intel SE7501wv2's
under
> >>>2.4.21-pre5-ac1. The systems are running Cerberus (ctcs). They fail
the
> >>>kcompile, and memtst tests.
> >>>
> >>>
> >>Are you running the aic79xx driver version embedded in that kernel
version
> >>or the latest from my site?
> >>
> >>http://people.FreeBSD.org/~gibbs/linux/SRC/
> >>
> >>
> >>
> >Justin,
> >
> > would you call the 1.3.6 version of aic79xx stable or "production
> >quality"? There still seems to be quite a lot of changes going on.
> >
> >
> >
>
>    Up until this point I've found the aic79xx driver to be very stable.
>  I know people running 100s of systems without issue on older revs of
> the driver.
>

 The point is that the older drivers seem to be a bit fragile when things
go wrong. If everything is perfect, the 1.1.0 driver is OK. If you
something "marginal" in the setup things get ugly. So I'd like to know
which version Justin would reccomend :-)

Martin


