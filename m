Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282174AbRKWQYY>; Fri, 23 Nov 2001 11:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282178AbRKWQYO>; Fri, 23 Nov 2001 11:24:14 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:58910 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S282174AbRKWQX4>; Fri, 23 Nov 2001 11:23:56 -0500
Date: Fri, 23 Nov 2001 10:23:42 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: war <war@starband.net>, Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Which gcc version?
In-Reply-To: <5.1.0.14.2.20011123142135.00a98ec0@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.3.96.1011123102257.32257C-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2001, Anton Altaparmakov wrote:

> At 14:11 23/11/01, war wrote:
> >#1) The compiler from redhat (gcc-2.96) is not an official GNU release.
> 
> And anyone should care because...?
> 
> >#2) http://www.atnf.csiro.au/~rgooch/linux/docs/kernel-newsflash.html/
> >       "the reccomend compiler is now gcc-2.95.3, rather than gcc-2.91.66"
> 
> Several main kernel developers use gcc-2.96 for their kernel development 
> work and according to Alan Cox using gcc-2.96 for the kernel is fine (from 
> a certain version onwards, can't remember the minimum release number he 
> said but the one in RH 7.2 is fine in any case).

Yes, 2.96 has a lot of bug fixes and is very well tested and stable at
this point.  I trust it more than 2.95.3, but not more than egcs-1.1.2 :)

	Jeff



