Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131123AbQLFCHx>; Tue, 5 Dec 2000 21:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131249AbQLFCHn>; Tue, 5 Dec 2000 21:07:43 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1540 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131123AbQLFCHg>; Tue, 5 Dec 2000 21:07:36 -0500
Subject: Re: That horrible hack from hell called A20
To: hpa@transmeta.com (H. Peter Anvin)
Date: Wed, 6 Dec 2000 01:26:57 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        kai@thphy.uni-duesseldorf.de, alan@redhat.com (Alan Cox)
In-Reply-To: <3A2D8509.117F6BD8@transmeta.com> from "H. Peter Anvin" at Dec 05, 2000 04:15:05 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E143TMJ-0000Ad-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Good question.  The whole thing makes me nervous... in fact, perhaps we
> should really consider using the BIOS INT 15h interrupt to enter
> protected mode?

>From my experience with BIOS authors, only if Windows 98 uses the same function
with the same arguments, the same stuff top of stack and the same segment
registers loaded ;)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
