Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132947AbRDRBKK>; Tue, 17 Apr 2001 21:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132942AbRDRBKA>; Tue, 17 Apr 2001 21:10:00 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:14229 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S132941AbRDRBJy>; Tue, 17 Apr 2001 21:09:54 -0400
Message-Id: <5.0.2.1.2.20010418020921.03e99d40@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Wed, 18 Apr 2001 02:12:00 +0100
To: esr@thyrsus.com
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: CML2 1.1.5, more comments
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010417174407.A6667@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A few comments on cml2 1.1.5 running on my Pentium 133S (make menuconfig, 
fastmode):

- Instantaneous moving up/down! Excellent!

- Thanks for dark blue! The cyan was barely readable. Now all the colours 
are nicely readable. I don't necessarily like your choice of colours but as 
long as I can read the text, that's fine.

- When I set something to yes it goes green. When I then set something else 
to yes the new one goes green, too, but the old one also remains green. Is 
this intended? (i.e. does green mean "already visited" or something like 
that?) Also, on the CPU selection menu, it started off with two of the CPUs 
already in green (but only one with a yes). Is that a feature or a bug?

- Moving left/right can still be quite painfully slow...

- Setting options is sometimes very slow, sometimes ok... (depends on 
complexity of underlying rules I guess)

It is definitely usable now compared to 1.1.0. But if the last two points 
could be speeded up, it would be great.

Best regards,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

