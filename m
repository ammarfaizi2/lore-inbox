Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277559AbRJZFoU>; Fri, 26 Oct 2001 01:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277598AbRJZFoK>; Fri, 26 Oct 2001 01:44:10 -0400
Received: from mail1.amc.com.au ([203.15.175.2]:17413 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S277559AbRJZFoD>;
	Fri, 26 Oct 2001 01:44:03 -0400
Message-Id: <5.1.0.14.0.20011026151926.00a23d60@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 26 Oct 2001 15:44:33 +1000
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Stuart Young <sgy@amc.com.au>
Subject: Re: linux-2.4.13..
Cc: Anuradha Ratnaweera <anuradha@gnu.org>, bert hubert <ahu@ds9a.nl>,
        Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20011026081728.A14607@bee.lk>
In-Reply-To: <20011024114026.A14078@outpost.ds9a.nl>
 <Pine.LNX.4.33.0110232249090.1185-100000@penguin.transmeta.com>
 <20011024114026.A14078@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:17 AM 26/10/01 +0600, Anuradha Ratnaweera wrote:
>IMHO _nothing_ should be done for the final.  A better alternative is to 
>name a stable pre kernel as a final without changes.  In the current 
>scenario, a final kernel release is one which is _not_ tested.

My "personal" opinion is that final's are for Documentation updates, 
correction of spelling errors in comments (not code, which needs testing), 
and *possibly* trivial updates to data files (eg: like 
linux/drivers/pci/pci.ids).

There have been a number of 2.4 issues in finals. Not all of them as 
staggering as 2.4.11, but things like the driver issues with the sblive 
(emu10k1) joystick stuff comes to mind, which was a 'final' addition. 
Admittedly it's not a hugely critical system, but it was fairly visible.

What would also be nice is a list of actual changed files for each patch 
mentioned in the ChangeLog, which if there is a problem between 2 revisions 
of a kernel (wether they're pre's of the same major kernel, or different 
major kernels), could really help pinpoint some problems a hell of a lot 
faster. Doesn't have to be in the ChangeLog, but it'd nice to have about 
(especially for those that don't keep every version of the kernel on disk).

Then again, opinions are like..... *grin*



AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

