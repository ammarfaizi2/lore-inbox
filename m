Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbRFEKeo>; Tue, 5 Jun 2001 06:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262585AbRFEKeY>; Tue, 5 Jun 2001 06:34:24 -0400
Received: from [213.38.169.194] ([213.38.169.194]:14856 "EHLO
	proxy.herefordshire.gov.uk") by vger.kernel.org with ESMTP
	id <S262580AbRFEKeO>; Tue, 5 Jun 2001 06:34:14 -0400
Message-ID: <AFE36742FF57D411862500508BDE8DD00199501D@mail.herefordshire.gov.uk>
From: "Randal, Phil" <prandal@herefordshire.gov.uk>
To: linux-kernel@vger.kernel.org
Subject: RE: TRG vger.timpanogas.org hacked
Date: Tue, 5 Jun 2001 11:33:57 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bind 8.2.4 was released on May 17th, with the standard
comment "BIND 8.2.4 is the latest version of ISC BIND 8.
We strongly recommend that you upgrade to BIND 9.1 or, if
that is not immediately possible, to BIND 8.2.4 due to
certain security vulnerabilities in previous versions."

However, there are no release notes on ISC's web site,
and their vulnerabilities page lists no known security
flaws in Bind 8.2.3.

But the paranoid part of me does wonder :-)

(And I haven't the time to do the diffs to see what's
changed.)

Cheers,

Phil

---------------------------------------------
Phil Randal
Network Engineer
Herefordshire Council
Hereford, UK 

> -----Original Message-----
> From: Daniel Roesen [mailto:dr@bofh.de]
> Sent: 05 June 2001 11:14
> To: linux-kernel@vger.kernel.org
> Subject: Re: TRG vger.timpanogas.org hacked
> 
> 
> On Tue, Jun 05, 2001 at 08:05:34AM +0100, Alan Cox wrote:
> > > is curious as to how these folks did this.  They 
> exploited BIND 8.2.3
> > > to get in and logs indicated that someone was using a 
> "back door" in 
> > 
> > Bind runs as root.
> 
> Not if set up properly. And there is no known hole in BIND 8.2.3-REL
> so I'm wondering how Jeff found out that the intruder got in via BIND.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
