Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282205AbRKWS4n>; Fri, 23 Nov 2001 13:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282206AbRKWS4d>; Fri, 23 Nov 2001 13:56:33 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:36604 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S282205AbRKWS4Q>; Fri, 23 Nov 2001 13:56:16 -0500
Message-Id: <5.1.0.14.2.20011123185333.00afd920@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 23 Nov 2001 18:56:07 +0000
To: Daniel Phillips <phillips@bonn-fries.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Which gcc version?
Cc: war <war@starband.net>, Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <E167L5w-0002Oi-00@starship.berlin>
In-Reply-To: <5.1.0.14.2.20011123135801.00aad970@pop.cus.cam.ac.uk>
 <20011123125137Z282133-17408+17815@vger.kernel.org>
 <5.1.0.14.2.20011123135801.00aad970@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:30 23/11/01, Daniel Phillips wrote:
>On November 23, 2001 02:59 pm, Anton Altaparmakov wrote:
> > At 13:51 23/11/01, war wrote:
> > >You should use gcc-2.95.3.
> >
> > That's not true. gcc-2.96 as provided with RedHat 7.2 is perfectly fine.
> >
> > gcc-3x OTOH is not a good idea at the moment.
>
>Do you have any particular reason for saying that?

I haven't done any measurements myself but from what I have read, gcc-3.x 
produces significantly slower code than gcc-2.96. I know I should try 
myself some time... but if that is indeed true that is a very good reason 
to stick with gcc-2.96.

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

