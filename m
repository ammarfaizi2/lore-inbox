Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135822AbRAGFdR>; Sun, 7 Jan 2001 00:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135839AbRAGFdH>; Sun, 7 Jan 2001 00:33:07 -0500
Received: from mail.sun.ac.za ([146.232.128.1]:48399 "EHLO mail.sun.ac.za")
	by vger.kernel.org with ESMTP id <S135822AbRAGFc6>;
	Sun, 7 Jan 2001 00:32:58 -0500
Date: Sun, 7 Jan 2001 07:32:50 +0200 (SAST)
From: Hans Grobler <grobh@sun.ac.za>
To: mull <mullein@mullein.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: SCSI hangs with aic7xxx in 2.4.0 SMP
In-Reply-To: <20010106164303.A2834@mullein.org>
Message-ID: <Pine.LNX.4.30.0101070727160.17598-100000@prime.sun.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2001, mull wrote:
> On Sat, Jan 06, 2001 at 09:26:55PM -0000, Craig Freeze wrote:
> > [1.] One line summary of the problem:
> > SCSI hangs with aic7xxx in 2.4.0 SMP
> >
> > [2.] Full description of the problem/report:
> > SCSI device errors and bus resets observed in 2.4.0 that do not occur in
> > 2.2.13.  Sysrq keys have no effect (ie hard reset required to recover)
> >
> I've noticed pretty much the same situation on my uniproc box, aic7xxx driver,
> adaptec 2940uw card since going to 2.4.0-prerelease. haven't had to hard
> reset, but have seen a LOT of scsi timeout errors. i did not notice this
> on 2.4.0-test12 or test13pre2. when i'm at home i'll see if i can find
> any pattern or more info, and also test with 2.4.0 final.
> mullein

I have not seen any such problems, even under very high loads. Would
you please submit a detailed bug report (such as the previous poster)
using the guidelines in REPORTING-BUGS.

Thanks,
-- Hans


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
