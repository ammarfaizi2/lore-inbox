Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266169AbRF2Tns>; Fri, 29 Jun 2001 15:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266167AbRF2Tnj>; Fri, 29 Jun 2001 15:43:39 -0400
Received: from cx48762-a.cv1.sdca.home.com ([24.0.158.22]:65085 "EHLO
	train.sweet-haven.com") by vger.kernel.org with ESMTP
	id <S266166AbRF2Tnf>; Fri, 29 Jun 2001 15:43:35 -0400
Date: Fri, 29 Jun 2001 12:41:51 -0700 (PDT)
From: Lew Wolfgang <wolfgang@train.sweet-haven.com>
To: Pavel Machek <pavel@suse.cz>
cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, <lm@bitmover.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: The latest Microsoft FUD.  This time from BillG, himself.
In-Reply-To: <20010629000255.B525@bug.ucw.cz>
Message-ID: <Pine.LNX.4.33.0106291207140.5284-100000@train.sweet-haven.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2001, Pavel Machek wrote:

> > The biggest improvement would be that users could remain with a version
> > that works for them and NOT be forced to pay more money for the same
> > functionality (watch out for the XP license virus... also known as
> > a logic bomb).
>
> What is XP license virus?

Hi Pavel,

I'm not sure it's like a virus, maybe more like a genetic defect.

This is Micro$oft's new licensing scheme that made its first
appearance with the SR1 edition of Office 2000.  I've been subjected
to it twice now, with Office 2000 and Office XP.  Windows XP will
use the same scheme.

It seems to be a multifaceted license manager that does the following
when installed:

1.  Sniffs around the hardware, building a list of what's installed.
    This serves as a "fingerprint" for the Pea Sea.

2.  The user enters the CD "key", a unique serial number for the
    software you purchased.

3.  A new encrypted string containing the sftwe key and the hardware
    fingerprint is now generated.  This new key must be provided to
    Microsoft where they then generate a third key based on the
    second.  This new key must be entered to "unlock" the software.

If this sequence is not followed, Office will run only 50 times, then
shut itself down.  (I bet it leaves "spoor" somewhere to prevent the
average user from just reinstalling from the CD.  I heard that
Windows XP will run only 5 times before shutdown without the final key.

Note that the manager encourages the user to use the automatic method
for sending the key to Micro$oft.  A form is filled out with name,
organization, address, phone number and such before a button is
pressed to send your personal profile off to the Borg.  The return
address has to be valid or you can't get the final, third key.
(In all fairness, they will allow telephone key transmittal that
can be anonymous.  This is what I did from a public phone booth)

So, Micro$oft now has lots of information about you.  If the
CD key is used again they just refuse to send the final key.
Further, if your hardware environment changes (adding a new
frame buffer, scsi controller, etc) the license manager assumes
you copied the whole disk to another computer and are therefore
a pirate.  It shuts down the package until a new key can be
obtained from Micro$oft, presumably after you convince them
that you aren't really a crook.  "I just added a disk!  Please
turn my Windows on again!  I promise to be good and send you
more money in the future.", can be heard across the land.

This whole thing will probably be good for the Open Source
Movement.  We won't have to "pull" users from the Borg,
the Borg will start "pushing" them to us.

Interesting times in which we live, what?

Regards,
Lew Wolfgang


