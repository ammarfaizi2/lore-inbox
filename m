Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbTIRQCc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 12:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTIRQCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 12:02:32 -0400
Received: from lucidpixels.com ([66.45.37.187]:964 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261756AbTIRQCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 12:02:30 -0400
Date: Thu, 18 Sep 2003 12:02:27 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p500
To: linux-kernel@vger.kernel.org
Subject: Shutdown question.
Message-ID: <Pine.LNX.4.58.0309181155390.9403@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an ABIT IC7-G and using the original bios that came with the box it
would shutdown all the way with: shutdown -i 0 -g 0 -y, however now that I
have upgraded the bios to the newest, it stops at Flushing devices, etc,
etc, then Power Down, but it stays there.

Another thing too, when I have the i8xx random number generator enabled
WHEN using the old bios, I get TONS of errors all over the place when
doing file copies, md5sums and so on.

When I use do not use a kernel with the i8xx random number generator,
there are no problems at all, and I can shut down.

I've e-mailed ABIT but have not received any response regarding this
issue.

I am currently using ic717.exe BIOS revision, there may be a newer one
now...

As far as the errors go, I do not have have bad ram or a bad HDD, and I
only got all those 'file input/output error' etc when I had the random
number generator (i8xx) support turned on with the older bios.  With the
newer bios, I do not have any such issues with the i8xx enabled.

It seems as if maybe this motherboard / linux have
something/incompatiblity/in terms of fully powering down?  Is there
something new about i875 motherboards that still is a problem even up to
2.4.22 kernels with shutting down?

It would be nice to be able to shutdown the machine and have it power off,
this isn't an old AT-based computer that requires you to flip the switch
to fully power it off ;)

Does anyone have any solutions? I've asked A-Bit 3-4 weeks ago, as to
that, no response.  I've tried many different BIOS', but the only one that
will fully shutdown is the one that came with the board (03/27/2003) is
the datecode on that BIOS if I remember correctly.

I am not sure what else to try at this moment.


