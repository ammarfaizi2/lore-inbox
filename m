Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282212AbRKWT1F>; Fri, 23 Nov 2001 14:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282213AbRKWT0z>; Fri, 23 Nov 2001 14:26:55 -0500
Received: from dsl-213-023-043-128.arcor-ip.net ([213.23.43.128]:49423 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S282212AbRKWT0u>;
	Fri, 23 Nov 2001 14:26:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Which gcc version?
Date: Fri, 23 Nov 2001 20:28:49 +0100
X-Mailer: KMail [version 1.3.2]
Cc: war <war@starband.net>, Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011123135801.00aad970@pop.cus.cam.ac.uk> <5.1.0.14.2.20011123185333.00afd920@pop.cus.cam.ac.uk>
In-Reply-To: <5.1.0.14.2.20011123185333.00afd920@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E167M0I-0002PD-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 23, 2001 07:56 pm, Anton Altaparmakov wrote:
> At 18:30 23/11/01, Daniel Phillips wrote:
> >On November 23, 2001 02:59 pm, Anton Altaparmakov wrote:
> > > At 13:51 23/11/01, war wrote:
> > > >You should use gcc-2.95.3.
> > >
> > > That's not true. gcc-2.96 as provided with RedHat 7.2 is perfectly fine.
> > >
> > > gcc-3x OTOH is not a good idea at the moment.
> >
> >Do you have any particular reason for saying that?
> 
> I haven't done any measurements myself but from what I have read, gcc-3.x 
> produces significantly slower code than gcc-2.96. I know I should try 
> myself some time... but if that is indeed true that is a very good reason 
> to stick with gcc-2.96.

If it does I certainly haven't noticed it.  I think we managed to get 2.4 
running slower than 2.2 for a while, and we all ran those kernels anyway, 
whether we had to or not, right?

If there is a performance hit, it's not enough to worry about.

--
Daniel
