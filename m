Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314641AbSDTQN1>; Sat, 20 Apr 2002 12:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314642AbSDTQN0>; Sat, 20 Apr 2002 12:13:26 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:35361 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S314641AbSDTQN0>; Sat, 20 Apr 2002 12:13:26 -0400
Message-Id: <5.1.0.14.2.20020420170907.06e87550@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 20 Apr 2002 17:13:25 +0100
To: Daniel Phillips <phillips@bonn-fries.net>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E16ya3u-0000RG-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

This is not documentation for bitkeeper but how to use bitkeeper 
effectively for kernel development. It happens to be DAMN USEFULL 
documentation at that for anyone wanting to use bitkeeper for kernel 
development so IMO it fully belongs in the kernel. Just like the 
SubmittingPatches document does, too. Or are you going to remove that as well?

If you don't want to use bitkeeper you don't need to read this 
documentation. Just ignore it and stick with what is SubmittingPatches 
document.

What's your problem?

Best regards,

Anton

At 16:12 19/04/02, Daniel Phillips wrote:
>Hi Linus,
>
>I have up to this point been open to the use of Bitkeeper as a development
>aid for Linux, and, again up to this point, have intended to make use of
>Bitkeeper myself, taking a pragmatic attitude towards the concept of using
>the best tool for the job.  However, now I see that Bitkeeper documentation
>has quietly been inserted ino the Linux Documentation directory, and that
>without any apparent discussion on lkml.  I fear that this demonstrates that
>those who have called the use of Bitkeeper a slippery slope do have a point
>after all.
>
>I respectfully request that you consider applying the attached patch, which
>reverses these proprietary additions to the Documentation directory.  Perhaps
>a better place for this documentation would be on kernel.org if Peter Anvin
>agrees, or the submitter's own site if he does not.  Or perhaps bitkeeper.com
>would be willing to host these files.
>
>Please do not misinterpret my position: I count Larry as something more than
>a personal acquaintance.  I strongly support his efforts to build a business
>for himself out of his Bitkeeper creation.  I even like Jeff Garzik's
>documentation, the subject of this patch.  I do not support the infusion of
>documentation for proprietary software products into the Linux tree.  The
>message is that we have gone beyond optional usage of Bitkeeper here, and it
>is now an absolute requirement, or it is on the way there.
>
>I hope that this proposed patch will receive more discussion than the
>original additions to Documentation did.
>
>Thankyou,
>
>Daniel

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

