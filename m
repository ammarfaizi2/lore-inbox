Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278390AbRJMUMM>; Sat, 13 Oct 2001 16:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278391AbRJMUME>; Sat, 13 Oct 2001 16:12:04 -0400
Received: from august.V-LO.krakow.pl ([62.121.131.17]:47115 "EHLO
	august.V-LO.krakow.pl") by vger.kernel.org with ESMTP
	id <S278389AbRJMULs>; Sat, 13 Oct 2001 16:11:48 -0400
Date: Sat, 13 Oct 2001 22:12:46 +0200 (CEST)
From: "[solid]" <solid@V-LO.krakow.pl>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Which is better at vm, and why? 2.2 or 2.4
In-Reply-To: <02ca01c1541d$391c5f30$c800000a@Artifact>
Message-ID: <Pine.LNX.4.33.0110132203010.6290-100000@august.V-LO.krakow.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

froma  completely non-developer point of view:
to me it seems that th overall speed of 2.4 kernels is much faster,
even on machines like p133 16 mb ram. it may sound silly, but software
justs tends to do its work faster while using the 2.4 series.
especially operations like mounting a big filesystem(<5GB) which
happen almost immediatly, comparing to 5-10second times of mounting
10GB under 2.2. i even managed to work on a 386 20 mhz/4mb ram laptop
witch 8mb swap on a very slow disk, and it was quite workable,
although it had very few kernel options compiled in(well, there was
networking!:) and when i added plip it was just to big...but i thing
that the days of computers with 4 megs of ram are over now, and these
200-400KB difference in kernel image size doesn't make such a big
difference. the scary fact is, that the next kernel series(the stable
one after 2.5) might not fit on a floppy! :)
but for now...to me 2.4 seems the best choice for any kind of linux
box.

[solid]
Registered Linux user number 212159


