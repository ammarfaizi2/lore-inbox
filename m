Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129411AbQKQQms>; Fri, 17 Nov 2000 11:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129856AbQKQQmj>; Fri, 17 Nov 2000 11:42:39 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:5133 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129411AbQKQQmb>; Fri, 17 Nov 2000 11:42:31 -0500
Date: Fri, 17 Nov 2000 11:11:56 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
To: Erik Andersen <andersen@codepoet.org>
cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test11-pre6
In-Reply-To: <20001117003046.A16984@codepoet.org>
Message-ID: <Pine.LNX.4.21.0011171110350.735-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, Erik Andersen wrote:

>> >     - Rik Faith: DRM update to make it easier to sync up 2.2.x
>> >     - David Woodhouse: make old 16-bit pcmcia controllers work
>> >       again (ie i82365 and TCIC)
>> Level I
>> 
>> The list is getting shorter.  
>
>WTF is "Level I" supposed to mean and why have you inserted it seemingly
>randomly into the changelog and why are you telling the world about it?  I've
>seen you do this several times and I am completely baffled.  Surely you have
>some reason for wanting to share?

I believe he is pointing out showstopper bugs getting fixed, and
the number of them decreasing over time thus symbolizing we're
close to a 2.4.0 kernel release.  That is what I see anyway..



----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

#[Mike A. Harris bash tip #3 - how to disable core dumps]
# Put the following at the bottom of your ~/.bash_profile
ulimit -c 0

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
