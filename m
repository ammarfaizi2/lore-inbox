Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130721AbQKGApR>; Mon, 6 Nov 2000 19:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130720AbQKGApH>; Mon, 6 Nov 2000 19:45:07 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:45001 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S130719AbQKGAou>; Mon, 6 Nov 2000 19:44:50 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: Gerhard Mack <gmack@innerfire.net>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Date: Tue, 7 Nov 2000 00:43:52 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10011061640330.31249-100000@innerfire.net>
In-Reply-To: <Pine.LNX.4.10.10011061640330.31249-100000@innerfire.net>
MIME-Version: 1.0
Message-Id: <00110700444305.00940@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2000, Gerhard Mack wrote:
> On Tue, 7 Nov 2000, James A. Sutherland wrote:
> 
> > On Mon, 06 Nov 2000, Gerhard Mack wrote:
> > > Sure .. lets see you start a laptop in class or buisness meeting and have
> > > everyone turn to look at you wondering why your laptop let off an ear
> > > piercing shreak because the hardware defaults to all settings max.
> > 
> > That only happens if the driver is stupid enough to try guessing "correct"
> > volume settings. If it leaves well alone until it KNOWS the correct settings,
> > there is no ear piercing shriek. Nor is there any break in the sound if you
> > were listening to something from the mixer.
> > 
> > > And you will _STILL_ have that shriek for 1/2 - 1 second before the
> > > userspace app loads.
> > 
> > Wrong. The userspace app is the one triggering the device init, when it gives
> > the sound driver the correct volume settings. There is no half second delay.
> > 
> > > And no we couldn't unplug either the mike or the speakers since they come
> > > embedded in the laptop's case. 
> > > 
> > > I don't see in any of your trolling an answer for this problem.
> > 
> > It isn't trolling, and there is a perfectly simple answer, as I have already
> > explained.
> > 
> 
> And if I don't use modules?

Then none of this is relevant to you, since you can't unload any modules! And
now you're the one doing the trolling... WTF do you think module code is
supposed to do when you don't use modules?!


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
