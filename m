Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRA3I5K>; Tue, 30 Jan 2001 03:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129789AbRA3I47>; Tue, 30 Jan 2001 03:56:59 -0500
Received: from james.kalifornia.com ([208.179.0.2]:59948 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129742AbRA3I4o>; Tue, 30 Jan 2001 03:56:44 -0500
Message-ID: <3A768281.6AEF839E@kalifornia.com>
Date: Tue, 30 Jan 2001 00:59:45 -0800
From: Ben Ford <ben@kalifornia.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Dax Kelson <dax@gurulabs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Multiplexing mouse input
In-Reply-To: <Pine.SOL.4.30.0101300017310.12047-100000@ultra1.inconnect.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are probably talking about an Xfree issue.  And yes it can be done.  I
know several people that do that.  Refer to the XFree86 website.

-b


Dax Kelson wrote:

> My laptop has a touchpad builtin with two buttons, I also have an external
> PS2 and/or USB mouse (3 buttons with scroll wheel).
>
> I would like to be able to use the touchpad, and then plug in the mouse
> (with either PS2 or USB connector) and use it without reconfiguring
> anything.
>
> In fact, it would be cool if I could use both at the same time.
>
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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
