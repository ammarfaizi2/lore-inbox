Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQKERPv>; Sun, 5 Nov 2000 12:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129657AbQKERPl>; Sun, 5 Nov 2000 12:15:41 -0500
Received: from [212.115.175.146] ([212.115.175.146]:46320 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S129260AbQKERPc>; Sun, 5 Nov 2000 12:15:32 -0500
Message-ID: <27525795B28BD311B28D00500481B7601623D5@ftrs1.intranet.FTR.NL>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: "'Linux Kernel Development'" <linux-kernel@vger.kernel.org>
Subject: i82808 hardware hub RNG
Date: Sun, 5 Nov 2000 18:19:21 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wrote a daemon that fetches (as root-user) random numbers from the RNG in
the i82808 (found on 815-chipsets).
You can download it from http://www.vanheusden.com/Linux/random.php3 .
Currently, I'm trying to rewrite things into a kernel-module so that one has
a standard character device which can deliver random values then.
Please give it a try as I do not own a PC with such a motherboard ;-/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
