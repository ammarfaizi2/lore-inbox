Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130758AbQLJQzL>; Sun, 10 Dec 2000 11:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130842AbQLJQzC>; Sun, 10 Dec 2000 11:55:02 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:44562 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130758AbQLJQys>;
	Sun, 10 Dec 2000 11:54:48 -0500
Message-ID: <3A33AE2D.A8E6053@mandrakesoft.com>
Date: Sun, 10 Dec 2000 11:24:13 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "Theodore Y. Ts'o" <tytso@MIT.EDU>, rgooch@ras.ucalgary.ca,
        jgarzik@mandrakesoft.mandrakesoft.com, dhinds@valinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: Serial cardbus code.... for testing, please.....
In-Reply-To: <Pine.LNX.4.10.10012100814230.2635-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Oh, serial_cb shouldn't work anyway, I think.

As soon as the serial.c hotplug patch appear, you'll be receiving a
patch that eliminates serial_cb.

	Jeff


-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
