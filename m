Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSIGOu5>; Sat, 7 Sep 2002 10:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315779AbSIGOu5>; Sat, 7 Sep 2002 10:50:57 -0400
Received: from 62-190-217-229.pdu.pipex.net ([62.190.217.229]:14856 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S315374AbSIGOu4>; Sat, 7 Sep 2002 10:50:56 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209071502.g87F2dCQ001040@darkstar.example.net>
Subject: Re: ide drive dying?
To: degger@fhm.edu (Daniel Egger)
Date: Sat, 7 Sep 2002 16:02:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1031406606.12089.109.camel@sonja.de.interearth.com> from "Daniel Egger" at Sep 07, 2002 03:50:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Besides, you *do* backup, don't you?
> 
> I do but besides that there is still data loss involved and my time is
> expensive and limited, so I'd rather go for a hasslefree solution than
> to poke around in mud with a stick in the hope it might clear up.

Fair enough, if you don't have the time to devote to it, it's best to replace the drive.

I assumed from the size of this thread, which has nothing to do with the kernel anymore, that we were trying to find out what was to blame.

If this is going to become a flamewar, please remove the cc: to the kernel list, as I doubt that it interests them.

> > (Or do what Linus suggested a while ago, and upload your stuff to an
> > ftp site that is mirrored worldwide.)
> 
> Very practicable advise.

Whatever - it was a joke.

The reason I brought up backups, was because even if you have a RAID array, of high quality drives, with non-sequential serial numbers, on hot-pluggable interfaces, with known good firmware, you can still get silent data corruption.

Fact - *NO* SLED, or RAID array, can ever be guaranteed never to silently flip a bit.

> > I don't see the point of returning a disk that turns out not to be
> > faulty after the firmware upgrade,
> 
> The point is that until you know whether it really was the firmware,
> you've spend so much time that it is much easier to return the drive.

And the chances are you will get another drive of the same model, back from IBM.  How does that help?

I already pointed out that there are two known issues here with these drive - firmware bugs, and media defects.

So far, all we can say is that the firmware problem is now fixed.  On a replacement drive, you can't even say that.

The 'media errors' could have been caused entirely by the buggy firmware.

> > even if it qualifies for a warranty replacement, (which it shouldn't do)
> 
> A faulty drive is a faulty drive and thus qualifies for a
> free replacement (at least in Germany). Nobody here can force
> you to try several costly things which might solve the problem;
> it is rather the manufacturers duty to fix it on their cost.

No, but you've upgraded the firmware, right?  If that has fixed the problem, then it is not a faulty drive.  If it is not a faulty drive, then what is the point in sending it back?  If it is not a faulty drive, IBM would be justified in sending it right back to you at your expense.  Oh, and it might get damaged in transit.

> > because you might be exchanging a good disk for a bad disk.
> 
> Very doubtful considering past experience. Also it's not very
> probable (though it has happened) to receive a disk which is
> more broken than broken.=20

No, I would say it is very possible that you could receive a disk with the old firmware on it.  So, you'll just plug in your 'new' disk, and in a few months, bad sectors will start appearing.

John.
