Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130216AbRABXFe>; Tue, 2 Jan 2001 18:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130386AbRABXFO>; Tue, 2 Jan 2001 18:05:14 -0500
Received: from femail1.sdc1.sfba.home.com ([24.0.95.81]:56319 "EHLO
	femail1.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S130216AbRABXFI>; Tue, 2 Jan 2001 18:05:08 -0500
Message-ID: <3A525923.330B0482@flash.net>
Date: Tue, 02 Jan 2001 17:41:39 -0500
From: Rob Landley <landley@flash.net>
X-Mailer: Mozilla 4.7 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: CPRM copy protection for ATA drives
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Its probably very hard to defeat. It also in its current form means
> you can throw disk defragmenting tools out. Dead, gone. Welcome to
> the United Police State Of America. 

Doesn't anybody remember the days of "dongle keys" on the Commodore 64? 
Plug a special circuit into the joystick port in order to use this
program?

And we all remember how the pirates got around this, don't we?  The easy
way: crack the program.

This is yet another hardware based copy protection tool like floppy
disks with strategically placed holes burned into them by lasers
(leaving a bad sector you can't reformat away), or cartridge-based
programs that tried to overwrite their own memory address ranges.  Or
forcing people to the third word from paragraph two on page ten of the
instruction manual (since the manual is, more or less, hardware.) 
Welcome back to the 1980's, they never learn...

There's nothing new under the sun, and the "zero day warez" people never
even broke stride dealing with this sort of thing.  All it WILL do is
annoy people who try to legitimately use the system.  And, of coruse,
make a lot more people buy SCSI if they sabotage the ATA spec this
way...

What are they going to do installing one of these programs on a
non-compliant drive?  (A modern 74 gig drive is likely to last me a
while, you know.)  Refuse and limit their potential installed base to
only systems manufactured after 2002?  Yeah, people do that kind of
thing all the time (requires MMX), and the products don't last that long
on the shelves, do they?

Has anybody brought up the LEVELS of nested stupidity in this particular
proposal to the committe?  (Committee iq: average intelligence of
members, divide by headcount.  Nice to see that holds true.)

I'm not particularly alarmed by it, though.  Disappointed, yes.  But a
market that refused to buy micro-channel architecture, refused to buy
rambus memory, and outright laughed at Microsoft BOB, isn't likely to
let this get shoved down its throat even if it DOES pass as an official
spec.  And another advantage Open Source has over proprietary software
(we provide what the users actually WANT, if only 'cause we're the
users.  A GPLed program isn't likely to depend on this "feature", is
it?  Or the Intel CPU ID...).

Rob
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
