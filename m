Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270593AbRHNMBv>; Tue, 14 Aug 2001 08:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270607AbRHNMBm>; Tue, 14 Aug 2001 08:01:42 -0400
Received: from fatbird.isisweb.nl ([212.204.202.107]:55046 "HELO
	fatbird.isisweb.nl") by vger.kernel.org with SMTP
	id <S269761AbRHNMBX>; Tue, 14 Aug 2001 08:01:23 -0400
Date: Tue, 14 Aug 2001 14:01:31 +0200 (CEST)
From: Ime Smits <ime@isisweb.nl>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Camino 2 (82815/82820) v2.4.x eth/sound related lockups
In-Reply-To: <E15WcZ9-0000zr-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108141351320.3880-100000@fatbird.isisweb.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


INDIVIDVVS VOCATVR Alan Cox DIE 14/8/2001 12:40 VERE SCRIPSIT:

| Those are not so good. I was having similar problems on an i810 box with
| onboard eepro100 until I disabled the pm stuff in 2.4.8ac2, but you
| seem to be running that one

Already figured that out. Oh, and I forget to mention that the same lockups
happen with all 2.4  versions I was able to find on my boxen, including
2.4.0, -ac7, 2.4.2, 2.4.5, 2.4.5-ac3, -ac5, 2.4.6,  2.4.7, 2.4.8 and -ac2,
so this is not something introduced in recent kernels. With
2.4.8-ac2 I  played with enabling/disabling ACPI & PM stuff and also APIC
irq stuff as mentioned in the eepro100 thread. No go.

Ime

