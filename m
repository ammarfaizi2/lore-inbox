Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129095AbQKDTlv>; Sat, 4 Nov 2000 14:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129103AbQKDTlk>; Sat, 4 Nov 2000 14:41:40 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:35076 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129095AbQKDTl3>;
	Sat, 4 Nov 2000 14:41:29 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200011041941.WAA28119@ms2.inr.ac.ru>
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sat, 4 Nov 2000 22:41:12 +0300 (MSK)
Cc: ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <3A032E32.39E7B151@mandrakesoft.com> from "Jeff Garzik" at Nov 3, 0 04:29:22 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> de4x5 is becoming EISA-only in 2.5.x too, since its PCI support is
> duplicated now in tulip driver.

Luckily, my old Multia died. 8)

Jeff, tulip did not work with genuine Digital cards.
de4x5 was faulty (link state machine was broken, it has lost
link after some events on wire) but it worked yet.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
