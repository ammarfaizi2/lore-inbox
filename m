Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265205AbRGAQXe>; Sun, 1 Jul 2001 12:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265207AbRGAQXY>; Sun, 1 Jul 2001 12:23:24 -0400
Received: from datafoundation.com ([209.150.125.194]:32004 "EHLO
	datafoundation.com") by vger.kernel.org with ESMTP
	id <S265205AbRGAQXH>; Sun, 1 Jul 2001 12:23:07 -0400
Date: Sun, 1 Jul 2001 12:22:11 -0400 (EDT)
From: John Jasen <jjasen@datafoundation.com>
To: Dylan Griffiths <Dylan_G@bigfoot.com>
cc: Andrew Morton <andrewm@uow.edu.au>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: EEPro100 problems in SMP on 2.4.5 ?
In-Reply-To: <3B3E29B0.8B9AB310@bigfoot.com>
Message-ID: <Pine.LNX.4.30.0107011219580.1608-100000@flash.datafoundation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2001, Dylan Griffiths wrote:

> I'd love to do some of this, but since the box is now being shipped to a
> colo facility in New York, I don't really have a choice in the matter.
>
> Hopefully someone here doing SMP + EEPro100 can see if they can reproduce
> the issue (2.4.5 kernel).

I've had issues with the Intel cards, as well.

What revision of the card is it?

Have you tried the drivers available from Intel, to see if they do a
better job? In my case, they didn't.

I've also had reports, for a linux-2.2.x kernel, that sometimes its
guesswork as to whether stock kernel eepro100, the intel e100 driver, or
Don Becker's eepro100 will work on the beasts.

HTH.



