Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129821AbQKESIf>; Sun, 5 Nov 2000 13:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129822AbQKESIO>; Sun, 5 Nov 2000 13:08:14 -0500
Received: from [212.115.175.146] ([212.115.175.146]:50928 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S129821AbQKESIN>; Sun, 5 Nov 2000 13:08:13 -0500
Message-ID: <27525795B28BD311B28D00500481B7601623D8@ftrs1.intranet.FTR.NL>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: "'Philipp Rumpf'" <prumpf@parcelfarce.linux.theplanet.co.uk>
Cc: "'Linux Kernel Development'" <linux-kernel@vger.kernel.org>
Subject: RE: i82808 hardware hub RNG
Date: Sun, 5 Nov 2000 19:11:59 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wrote a daemon that fetches (as root-user) random numbers from the RNG
in
> the i82808 (found on 815-chipsets).
> You can download it from http://www.vanheusden.com/Linux/random.php3 .
> Currently, I'm trying to rewrite things into a kernel-module so that one
has
> a standard character device which can deliver random values then.
> Please give it a try as I do not own a PC with such a motherboard ;-/
PR> So how is this different from drivers/char/i810_rng.c ?

I don't know; 2.2.17 doesn't have it :-}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
