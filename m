Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272540AbRISRl3>; Wed, 19 Sep 2001 13:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274122AbRISRlT>; Wed, 19 Sep 2001 13:41:19 -0400
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:57030 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S272540AbRISRlO>; Wed, 19 Sep 2001 13:41:14 -0400
Date: Wed, 19 Sep 2001 12:41:38 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: disregard: Re: ide zip 100 won't mount
In-Reply-To: <courier.3BA68362.00004D02@ny.email-scan.com>
Message-ID: <Pine.LNX.4.33.0109191239090.12151-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001, Sam Varshavchik wrote:
> Joseph Cheek writes:
> > hmm, i went into windows *one more time* just to make sure it was still
> > working, and not a hardware problem.  well... looks like it doesn't work
> > in windows either.  must be hardware.
> >
> > funny thing it shows up in dmesg and in "My Computer", just can't read
> > from it.
>
> That's pretty much what the sense codes below did indicate - media problem.

For future reference, is there any sort of tool that will decode these
magic numbers, since the driver doesn't do it for us?  It ought to cut
down on the number of posts beginning, "my IDE driver began speaking in
tongues, what is it trying to tell me?"

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Make a good day.

