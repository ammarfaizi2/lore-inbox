Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281170AbRKKXvM>; Sun, 11 Nov 2001 18:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281171AbRKKXuw>; Sun, 11 Nov 2001 18:50:52 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:63749 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281170AbRKKXup>; Sun, 11 Nov 2001 18:50:45 -0500
Message-ID: <004601c16b0b$8b04bb80$f5976dcf@nwfs>
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
To: "Anton Altaparmakov" <aia21@cus.cam.ac.uk>,
        "Michael H. Warfield" <mhw@wittsend.com>
Cc: <lobo@polbox.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.3.96.1011111120107.21134C-100000@libra.cus.cam.ac.uk>
Subject: [RFC-ONT (on topic)] Modprobe enhancement (was Re:  "Dance of the Trolls")
Date: Sun, 11 Nov 2001 16:49:46 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton,

This is a great suggestion.  You should ping Keith Owens (does he own
modutils, I think so) and make it happen.  A much desireable change.

Jeff

----- Original Message -----
From: "Anton Altaparmakov" <aia21@cus.cam.ac.uk>
To: "Michael H. Warfield" <mhw@wittsend.com>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>; <lobo@polbox.com>;
<linux-kernel@vger.kernel.org>
Sent: Sunday, November 11, 2001 5:07 AM
Subject: [Very-OT] Re: Nazi kernels


> On Sun, 11 Nov 2001, Michael H. Warfield wrote:
> > Oh, but you missed the mark!  Think Windows XP.  Now there's
> > the ticket.  If you aren't a Windows XP certified driver, they can
> > just wipe your driver right off the face of the system...  All in the
> > name of "stability" (as they define it).  None of this nonsense of
> > merely flagging if their OS has a non-sanctified driver like Linux.
> > Linux lets the driver load and run, it merely lets people KNOW that
> > it's an un-sanctified driver when shit catches fire and burns.  You
> > know MS.  MS thinks Linux is just a bunch of whimps.  Screw just letting
> > the user know AFTER something burps and burns.  That's TOO complicated
> > for a user to figure out and MS has to be "user friendly".  MS is for
> > men with balls (and no brains)...  Just burn the driver BEFORE it has
> > a chance to run.  Yeah!  That's the ticket!
>
> Let's not get carried away. Windows XP does allow you to install anything
> you like. You just have to click several times on the Yes button when it
> asks things like "This driver is not XP certified. Do you really want to
> use it?" and "Installing a non-certified driver can cause system
> instability. Are you sure you want to do this?" (text is probably not
> quite right but you get the idea).
>
> I think we ought to do the same with closed source drivers. It's true
> after all... The whole point of tainting the kernel is so we can just yell
> at users to go and bug the vendor. So the modprobe executable could warn
> the user "hey, you are loading a binary only module, it can break the
> system, are you sure?". If the module is autoloaded we don't do jumping
> through hoops asking questions so the systen runs smoothly.
>
> Best regards,
>
> Anton
> --
> Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
> Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
> ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

