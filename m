Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318751AbSHQWHC>; Sat, 17 Aug 2002 18:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318752AbSHQWHC>; Sat, 17 Aug 2002 18:07:02 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:33944 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318751AbSHQWHC>; Sat, 17 Aug 2002 18:07:02 -0400
Message-Id: <5.1.0.14.2.20020817225323.021796b0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 17 Aug 2002 23:11:14 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: IDE?
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Andre Hedrick <andre@linux-ide.org>, axboe@suse.de, vojtech@suse.cz,
       bkz@linux-ide.org, linux-kernel@vger.kernel.org
In-Reply-To: <1029614199.4634.32.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com>
 <Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 20:56 17/08/02, Alan Cox wrote:
>Volunteers willing to run Cerberus test sets on 2.4 boxes with IDE
>controllers would also be much appreciated. That way we can get good
>coverage tests and catch badness immediately

If you tell me the kernel version and patches to apply which you want 
tested, and what options to run cerberus with (never used it before...), I 
have control over a currently idle dual Athlon MP 2000+ with an AMD-768 
(rev 04) IDE controller and 3G of RAM. It has only one HD, a ST340810A 
(ATA-100, 37G) attached.

btw. Is this where I get cerberus from?
         http://sourceforge.net/projects/va-ctcs/

The machine won't be in use for a few more weeks (until I find the time to 
configure all the software and the database server it will be connecting 
to...) so I can do tests during that period.

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

