Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAYANZ>; Wed, 24 Jan 2001 19:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129441AbRAYANQ>; Wed, 24 Jan 2001 19:13:16 -0500
Received: from vs-01.eizel.com ([208.205.224.125]:39946 "EHLO
	digital-mission.com") by vger.kernel.org with ESMTP
	id <S129406AbRAYANB>; Wed, 24 Jan 2001 19:13:01 -0500
Date: Wed, 24 Jan 2001 19:13:00 -0500 (EST)
From: Robert Dale <rdale@digital-mission.com>
To: linux-kernel@vger.kernel.org
Subject: SpeedStep,MHz,BogoMIPS,timing..
Message-ID: <Pine.LNX.4.10.10101241903540.20959-100000@vs-01.digipath.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I bought a laptop which uses an Intel CPU with SpeedStep.  Sometimes when
I boot the kernel recognizes the full MHz, and other times it is much less.
And of course the BogoMIPS reflect this we well.

I'm wondering if this has any sort of side-effect on the kernel?  Will
it disrupt timing loops and such? (I have no idea what I'm talking about ;)

Since Linus works at Transmeta, the kings of power saving, I'm guessing this
has no effect.

-- 
Robert Dale

                   Digital Mission


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
