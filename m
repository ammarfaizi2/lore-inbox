Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131256AbRA3QOr>; Tue, 30 Jan 2001 11:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131215AbRA3QOi>; Tue, 30 Jan 2001 11:14:38 -0500
Received: from twin.uoregon.edu ([128.223.214.27]:24502 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id <S131172AbRA3QOT>;
	Tue, 30 Jan 2001 11:14:19 -0500
Date: Tue, 30 Jan 2001 08:14:06 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
To: Dax Kelson <dax@gurulabs.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Multiplexing mouse input
In-Reply-To: <Pine.SOL.4.30.0101300017310.12047-100000@ultra1.inconnect.com>
Message-ID: <Pine.LNX.4.30.0101300810340.9081-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, Dax Kelson wrote:

>
> My laptop has a touchpad builtin with two buttons, I also have an external
> PS2 and/or USB mouse (3 buttons with scroll wheel).
>
> I would like to be able to use the touchpad, and then plug in the mouse
> (with either PS2 or USB connector) and use it without reconfiguring
> anything.

It's works on Toshiba's and some other varieties of laptop... typically
there's a setting like "simultanious point ing device in the bios"

> In fact, it would be cool if I could use both at the same time.

you can in those cases... in others (some older cannon laptops I know for
sure) connecting an external ps/2 device disables the internal...

> Is this possible with the new "Input Drivers" in the 2.4 kernel?  Is it
> possible with Linux at all?
>
> As a comparison, at least two other OSes, Windows 2000 and NetBSD 1.5
> multiplex mouse input and allow use of two (or more!) mice at the same
> time.
>
> Dax Kelson
>
> NetBSD "wscons console driver" info:
>
> http://www.netbsd.org/Documentation/wscons/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
