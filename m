Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313088AbSDDNhZ>; Thu, 4 Apr 2002 08:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313167AbSDDNhQ>; Thu, 4 Apr 2002 08:37:16 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:38302 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S313088AbSDDNhG>;
	Thu, 4 Apr 2002 08:37:06 -0500
Message-Id: <5.1.0.14.2.20020404142914.00a6aa70@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 04 Apr 2002 14:37:02 +0100
To: Padraig Brady <padraig@antefacto.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: ANN: NTFS 2.0.1 for kernel 2.5.7 released
Cc: Joachim Breuer <jmbreuer@gmx.net>,
        Nerijus Baliunas <nerijus@users.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-ntfs-dev@lists.sourceforge.net>
In-Reply-To: <3CA87ABE.9000709@antefacto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 16:20 01/04/02, Padraig Brady wrote:
>Joachim Breuer wrote:
>>Nerijus Baliunas <nerijus@users.sourceforge.net> writes:
>>
>>>On Fri, 29 Mar 2002 12:57:07 +0000 (GMT) Anton Altaparmakov 
>>><aia21@cus.cam.ac.uk> wrote:
>>>
>>>[...] Discussion about default fmask, mc, being able to run in place
>>>      snipped
>>>
>>>People using Linux usually keep data files on fat and ntfs permissions, not
>>>executables (IMHO).
>>
>>For the sake of another vote: Yes, I do use NTFS primarily for data
>>storage, and No, I don't like gratuitous x-bits. Not *at all*.
>
>Anton, there have been no votes the other way. What do you think now?

I am tending towards a default fmask of 0177 now. I will change it for the 
next release.

Happy? (-;

Cheers,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

