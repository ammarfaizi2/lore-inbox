Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275771AbRI0GAI>; Thu, 27 Sep 2001 02:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275773AbRI0F77>; Thu, 27 Sep 2001 01:59:59 -0400
Received: from haneman.dialup.fu-berlin.de ([160.45.224.9]:31872 "EHLO
	haneman.dialup.fu-berlin.de") by vger.kernel.org with ESMTP
	id <S275771AbRI0F7p>; Thu, 27 Sep 2001 01:59:45 -0400
Date: Thu, 27 Sep 2001 08:00:03 +0200 (CEST)
From: Enver Haase <ehaase@inf.fu-berlin.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 is toxic to my system when I use my USB webcam (was: More
 info. on crash)
Message-ID: <Pine.LNX.4.10.10109270754040.7880-100000@haneman.hacenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey, thanks for finding out what my problem is!

Yes, 2.4.9 worked rock solid, 2.4.10 almost instantly crashes
after init got control: That's why, because my webcam takes
pictures every minute via crond.

[I already put a quite simplicistic report on this on this list]

My Webcam is a Creative Webcam 3 (USB). I don't use modules but have the
drivers compiled into the kernel (Hope your explanation on what happened
is still valid.)

Greetings,
Enver

