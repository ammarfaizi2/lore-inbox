Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279607AbRJ0AN5>; Fri, 26 Oct 2001 20:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279632AbRJ0ANs>; Fri, 26 Oct 2001 20:13:48 -0400
Received: from four.malevolentminds.com ([216.177.76.238]:44303 "EHLO
	four.malevolentminds.com") by vger.kernel.org with ESMTP
	id <S279607AbRJ0AN2>; Fri, 26 Oct 2001 20:13:28 -0400
Date: Sat, 27 Oct 2001 00:14:08 +0000 (GMT)
From: Khyron <khyron@khyron.com>
X-X-Sender: <khyron@four.malevolentminds.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.8+6.2.4 unable to mount root fs on 08:05
Message-ID: <Pine.BSF.4.33.0110270013520.43580-100000@four.malevolentminds.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using an AIC-7896 SCSI card in a VA Linux 2230.
In a previous post, I had problems with getting the
6.2.4 driver from Justin Gibbs to work at all. Now
that I have moved past that one, this one is a little
more esoteric.

The 2.4.8+6.2.4 kernel is installed and configured
correctly. The 6.2.4 driver is statically linked into the
kernel and all SCSI information displays fine at system
boot. However, I am getting the message:

"Unable to mount root fs on 08:05"

and associated panic at boot.

So, since I can see the driver, and the same driver is
being used for the installation kernel image (same kernel
release too), I can't come up with an explanation for
the kernel's failure to find the root fs.

What can I do to troubleshoot this? What information would
be helpful?

Thoughts/comments/suggestions welcome. Thanks in advance!


"Everyone's got a story to tell, and everyone's got some pain.
 And so do you. Do you think you are invisble?
 And everyone's got a story to sell, and everyone is strange.
 And so are you. Did you think you were invincible?"
 	- "Invisible", Majik Alex


