Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276743AbRKAAbO>; Wed, 31 Oct 2001 19:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276675AbRKAAbF>; Wed, 31 Oct 2001 19:31:05 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:58577 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S276665AbRKAAaw>; Wed, 31 Oct 2001 19:30:52 -0500
Message-Id: <5.1.0.14.2.20011101001344.034cc9e0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 01 Nov 2001 00:30:39 +0000
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: EM8400/8401 support?
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0110312037070.28133-100000@mustard.heime.net
 >
In-Reply-To: <5.1.0.14.2.20011031174516.00abb140@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:44 31/10/01, Roy Sigurd Karlsbakk wrote:
> > As Sigma designs do not release specs nor sourcecode there is no open
> > source driver available and I am not aware of any non-official efforts to
> > produce drivers.
>
>strange...
>I found a package called NetStream2000-0.2.047.1.tar.gz with these drivers
>with source on Sigma's site.

Yeah, right. Why don't you download that tar ball, unpack it, and have a 
look what it contains before disseminating uninformed, and incorrect 
information?!?

To quote from the main readme of above tar ball:

"shared object libraries (libEM8400.so, libosd.so) in lib/
   are only available in binary form.
   Copyrighted (C) 1999-2000 Sigma Designs"

Those libraries are EVERYTHING that matters. And they are _binary_ only. 
The stuff that is actually given as source and even as GPL is just glue 
code which defines an API to access the binary only library and kernel 
modules which cause the library to be hooked into the kernel. This is just 
about as far as you can get from open source drivers!

>I also found tech spec on the EM840[01] open on their sites, although the 
>document was marked 'confidential'.

Ok, so I am stupid and am unable to find this document. Why don't you email 
me the URL so I can download it and see for myself? I would really very 
much appreciate it!!!

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

