Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270220AbRHRPRU>; Sat, 18 Aug 2001 11:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270222AbRHRPRA>; Sat, 18 Aug 2001 11:17:00 -0400
Received: from ns1.baby-dragons.com ([199.33.245.254]:2314 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S270220AbRHRPQx>; Sat, 18 Aug 2001 11:16:53 -0400
Date: Sat, 18 Aug 2001 11:17:01 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Ted Unangst <tedu@stanford.edu>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Encrypted Swap
In-Reply-To: <Pine.GSO.4.31.0108180744090.9012-100000@cardinal0.Stanford.EDU>
Message-ID: <Pine.LNX.4.33.0108181114270.15372-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Ted ,  Thank you for bring us back on topic .  I found the
	disertations on memory a tad enlightening .  But I was very
	interested in the original thread of encrypting swap .
		Twyl , JimL

On Sat, 18 Aug 2001, Ted Unangst wrote:
> On Sat, 18 Aug 2001, Eric W. Biederman wrote:
> > So the attacker has two way to attack your machine.  Attempt to break
> > in while it is still running.  Put in a minimal boot cd and press
> > reset and see how much is recovered.  Generally breaking should prove
> > the more fruitful course, but the fact that reset preseves all of the
> > memory, means it simply is not safe for someone to have physical
> > access to your machine while the power is on.
>
> if the machine is on, and you can get close to it, it's probably easier
> just to use tempest radiation.  it will also work at a distance, so it's
> more likely to be a threat than grabbing RAM chips.  a few points:
>
> 1.  not everyone is going to bring their James Bond RAM Reader (tm) into
> your building to extract data.  a hardcore data thief, maybe, but it's not
> common equipment.  everyone will have access to an IDE or SCSI disk
> reader.
>
> 2.  RAM has a short window of oppurtunity.  whatever it turns out to be,
> RAM degrades faster than disk.  it's not going to last while you drive it
> home, unless you have a RAM refresher plugged in the cigarette lighter.
>
> 3.  encrypted swap is meant for a different threat model.  you assume that
> the attacker might have access to the box at night or over a weekend,
> while you're away.  RAM will be off.  if you think someone might be trying
> to steal your RAM, you need better physical security.
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

