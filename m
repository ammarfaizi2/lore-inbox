Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130683AbQKGAk1>; Mon, 6 Nov 2000 19:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130684AbQKGAkQ>; Mon, 6 Nov 2000 19:40:16 -0500
Received: from innerfire.net ([208.181.73.33]:62983 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S130683AbQKGAkK>;
	Mon, 6 Nov 2000 19:40:10 -0500
Date: Mon, 6 Nov 2000 16:42:00 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: "James A. Sutherland" <jas88@cam.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <00110700362203.00940@dax.joh.cam.ac.uk>
Message-ID: <Pine.LNX.4.10.10011061640330.31249-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, James A. Sutherland wrote:

> On Mon, 06 Nov 2000, Gerhard Mack wrote:
> > Sure .. lets see you start a laptop in class or buisness meeting and have
> > everyone turn to look at you wondering why your laptop let off an ear
> > piercing shreak because the hardware defaults to all settings max.
> 
> That only happens if the driver is stupid enough to try guessing "correct"
> volume settings. If it leaves well alone until it KNOWS the correct settings,
> there is no ear piercing shriek. Nor is there any break in the sound if you
> were listening to something from the mixer.
> 
> > And you will _STILL_ have that shriek for 1/2 - 1 second before the
> > userspace app loads.
> 
> Wrong. The userspace app is the one triggering the device init, when it gives
> the sound driver the correct volume settings. There is no half second delay.
> 
> > And no we couldn't unplug either the mike or the speakers since they come
> > embedded in the laptop's case. 
> > 
> > I don't see in any of your trolling an answer for this problem.
> 
> It isn't trolling, and there is a perfectly simple answer, as I have already
> explained.
> 

And if I don't use modules?

	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
