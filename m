Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314058AbSECOnv>; Fri, 3 May 2002 10:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314128AbSECOnu>; Fri, 3 May 2002 10:43:50 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:37283 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314058AbSECOnu>; Fri, 3 May 2002 10:43:50 -0400
Date: Fri, 3 May 2002 15:43:44 +0100 (BST)
From: Anton Altaparmakov <aia21@cantab.net>
To: skmail@mcewen.wcnet.org
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel strangeness
In-Reply-To: <E173ePc-0006Uu-00@the-village.bc.nu>
Message-ID: <Pine.SOL.3.96.1020503154207.17346A-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002, Alan Cox wrote:

> > Thank you.  I will try replacing the glibc.  If I understand right (I'm 
> > not a programmer) I will need to recompile the kernel, and possibly some 
> > other programs, against the i386 glibc.  Correct?
> 
> You don't. You just need to replace the i686 rpm of glibc with the i386 one
> and all should be well

Note you probably will need to use the --force flag for this to work...

(At least I needed to use --force when going from i386 to i686 RH7.0 glibc
rpm last night as it complained about conflicting files otherwise...)

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

