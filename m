Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282219AbRKWUYn>; Fri, 23 Nov 2001 15:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282220AbRKWUYe>; Fri, 23 Nov 2001 15:24:34 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:24710 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S282219AbRKWUYQ>; Fri, 23 Nov 2001 15:24:16 -0500
Message-Id: <5.1.0.14.2.20011123201824.05610ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 23 Nov 2001 20:24:16 +0000
To: Andrew Morton <akpm@zip.com.au>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Which gcc version?
Cc: Daniel Phillips <phillips@bonn-fries.net>, war <war@starband.net>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3BFEAE22.1CE8DE5B@zip.com.au>
In-Reply-To: <5.1.0.14.2.20011123135801.00aad970@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20011123185333.00afd920@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20011123185333.00afd920@pop.cus.cam.ac.uk>
 <E167M0I-0002PD-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

At 20:14 23/11/01, Andrew Morton wrote:
>Daniel Phillips wrote:
> >
> > If there is a performance hit, it's not enough to worry about.
>
>except egcs-1.1.2 (2.91.6) compiles stuff at almost twice the speed
>of gcc3.  The person who breaks egcs-1.1.2 for kernel builds owes
>me a quad Xeon, thanks very much.

Have you read the current Documentation/Changes? It says "the 2.5 tree is 
likely to drop egcs-1.1.2 workarounds". Whoever wrote that seems to be 
wanting to break it in the near future...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

