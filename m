Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbRACC60>; Tue, 2 Jan 2001 21:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130012AbRACC6R>; Tue, 2 Jan 2001 21:58:17 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:46605 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129830AbRACC6I>; Tue, 2 Jan 2001 21:58:08 -0500
Date: Wed, 3 Jan 2001 03:27:20 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Rob Landley <landley@flash.net>, linux-kernel@vger.kernel.org
Subject: Re: CPRM copy protection for ATA drives
Message-ID: <20010103032719.I888@arthur.ubicom.tudelft.nl>
In-Reply-To: <3A5269DF.588D2C3F@flash.net> <Pine.LNX.4.10.10101021609140.26680-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101021609140.26680-100000@master.linux-ide.org>; from andre@linux-ide.org on Tue, Jan 02, 2001 at 04:15:02PM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2001 at 04:15:02PM -0800, Andre Hedrick wrote:
> However each key is to broadcasts its identity for the authorized
> host/application.  This every license that uses CPRM is trackable.  Since
> the method is exotic enough and you can only get the matrix pillars from
> the LC4 people, crack will be tough.  There is a 1Meg hidden CPRM space
> for key tracking and other services that are unknown.
> 
> How it works is still a fuzzy thought, even for the LC4 people.

[Don't read this as a personal attack. I know you're on the T13
committee and that you are against CPRM.]

Hmm... "every license is trackable"... "method is exotic"... "crack
will be tough"... I have a slight deja vu feeling: CSS.

I hope the T13 committee learned from the past. No amount of hardware
is going to help you to protect your data: once a backdoor is found,
the protection is useless. See region free DVD players, macrovision
decoders that allow you to make copies of VHS tapes, copy bit removers
for SPDIF audio streams. All these examples have one thing in common:
they were invented by the recording industry.

Why would the T13 committee try to be smart and think they can invent a
method that is guaranteed to be broken in a couple of months of time?
Once the method is broken nobody will use it anymore and the hardware
is just bloated with crap that the recording industy wants to be there,
at the same time unneccesary increasing the price for the hardware.
I really don't think it's worth the effort.

The recording industry has to realise that they already lost the game:
once you release your stuff on an open platform (the PC), there is no
way you're going to protect it.

> I have to kill this timeout bug or people will scream bloody murder.

Heh, please do ;-)


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
