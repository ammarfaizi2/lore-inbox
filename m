Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271618AbRHQUxA>; Fri, 17 Aug 2001 16:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271658AbRHQUwu>; Fri, 17 Aug 2001 16:52:50 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:50314 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S271618AbRHQUwo>; Fri, 17 Aug 2001 16:52:44 -0400
Message-Id: <5.1.0.14.2.20010817215031.00a84d90@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 17 Aug 2001 21:52:59 +0100
To: Peter Klotz <peter.klotz@aon.at>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Error on fs unmount
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01081722422601.01143@localhost.localdomain>
In-Reply-To: <5.1.0.14.2.20010817190012.04579580@pop.cus.cam.ac.uk>
 <01081718390800.01143@localhost.localdomain>
 <5.1.0.14.2.20010817190012.04579580@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:42 17/08/2001, Peter Klotz wrote:
> >Could you tell me whether on startup (or whenever you mount the NTFS
> >volume) it doesn't give a message but saying: "Trying to open system file
> >9!" or "Opening system file 9!".
>
>You were right. I found the message you mentioned several times in
>/var/log/messages:
>Aug 17 08:16:50 localhost kernel: Trying to open system file 9!

Excellent. That is exactly what I expected to see, so all is fine. Just 
ignore for now.

>Thanks a lot for your quick and helpful response.

You are welcome.

Cheers,

         Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

