Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129232AbRBSVgC>; Mon, 19 Feb 2001 16:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130060AbRBSVfw>; Mon, 19 Feb 2001 16:35:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57615 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130046AbRBSVfj>;
	Mon, 19 Feb 2001 16:35:39 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200102192134.f1JLYGu18870@flint.arm.linux.org.uk>
Subject: Re: The lack of specification
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Mon, 19 Feb 2001 21:34:16 +0000 (GMT)
Cc: mikulas@artax.karlin.mff.cuni.cz (Mikulas Patocka),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <200102192017.f1JKHO952286@saturn.cs.uml.edu> from "Albert D. Cahalan" at Feb 19, 2001 03:17:24 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan writes:
> The TCP maintainers do not seem to be sadistic bastards hell-bent on
> breaking your drivers. API changes usually have a good reason.

And when the API does change, like it has between Linux 2.2 and Linux 2.4,
an email gets sent to this list describing the change of API.  Search
this lists archives to find out:

1. the reasons for the change
2. a complete description of the new bits of the API

There are projects around to try to pick this stuff up and put it on the
web in one place - its called the Kernel Wiki, and iirc it is on
sourceforge.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

