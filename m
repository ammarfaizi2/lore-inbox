Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRAYO7a>; Thu, 25 Jan 2001 09:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129291AbRAYO7U>; Thu, 25 Jan 2001 09:59:20 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:17162 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129051AbRAYO7L>; Thu, 25 Jan 2001 09:59:11 -0500
Date: Thu, 25 Jan 2001 09:59:04 -0500 (EST)
From: "Mike A. Harris" <mharris@redhat.com>
X-X-Sender: <mharris@asdf.capslock.lan>
To: David Woodhouse <dwmw2@infradead.org>
cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Patches 
In-Reply-To: <19765.980417282@redhat.com>
Message-ID: <Pine.LNX.4.32.0101250957040.3118-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, David Woodhouse wrote:

>>  I seem to be getting more and more patches that have tabs/spaces
>> broken and line wrap damage. I've dumped a pile in my queue including
>> some pcmcia support for sh3 and the like
>
>Note that pine 4.30 (shipped with Red Hat 7) has taken to stripping
>trailing whitespace from each line of a mail just before it sends it.
>
>See http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=23679 for a patch,
>if you can get at it - I seem to be firewalled from it at the moment.
>
>This corruption still occurs in pine 4.32.

I will take a look at the patch and apply it to my next PINE
build for testing.


--
Mike A. Harris                  Mailing address:
OS Systems Engineer             190 Pittsburgh Ave.
Red Hat Inc.                    Sault Ste. Marie,
(705)949-2136                   Ontario, Canada, P6C 5B3

Fun thing to do as root, in the root directory:
chmod -R 666 *
Just as bad as rm -rf *, but more fun.
"The files are all there, but I can't do anything with them!"
And you can't change permissions, since chmod isn't executable either. :-)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
