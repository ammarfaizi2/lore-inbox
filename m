Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317945AbSG1Eg2>; Sun, 28 Jul 2002 00:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317946AbSG1Eg2>; Sun, 28 Jul 2002 00:36:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10246 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317945AbSG1Eg2>; Sun, 28 Jul 2002 00:36:28 -0400
Date: Sat, 27 Jul 2002 21:40:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Daniel Egger <degger@fhm.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Linux-2.5.28
In-Reply-To: <Pine.LNX.4.44.0207271939220.3799-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0207272131250.6125-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Jul 2002, Linus Torvalds wrote:
>
> I'm talking about people who don't even bother to do
> bug-reports, but only trash-talk the maintenance.

On that note, let me mention the machines I personally am using IDE, and
apparently do not see problems: a dual PII with "Intel Corp. 82371AB PIIX4
IDE", and a P4 with "SiS 5513 IDE (rev 208)".

Both setups in DMA mode, both setups have one disk per channel (first
channel is disk, second channel is CD-ROM).

So what are the patterns for "working" vs "broken"?

		Linus

