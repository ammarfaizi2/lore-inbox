Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277145AbRJDHE5>; Thu, 4 Oct 2001 03:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277146AbRJDHEs>; Thu, 4 Oct 2001 03:04:48 -0400
Received: from dsl-45-169.muscanet.com ([208.164.45.169]:51720 "EHLO
	dink.joshisanerd.com") by vger.kernel.org with ESMTP
	id <S277145AbRJDHEk>; Thu, 4 Oct 2001 03:04:40 -0400
Date: Thu, 4 Oct 2001 02:05:09 -0500 (CDT)
From: Josh Myer <jbm@joshisanerd.com>
To: linux-kernel@vger.kernel.org
Subject: USB Event Daemon?
Message-ID: <Pine.LNX.4.21.0110040158530.31009-100000@dignity.joshisanerd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This might belong on linux-usb, but i'm not subscribed there, and I figure
this is probably a better place to ask this question.

Is there, or if there were, would it be used, a method to notify a
user-space daemon/program of USB device insertions? A quick search through
archives didn't show anything.

Basically, i've been spoiled by OSX's "Image Capture" utility, which
launches an image offloader whenever i plug my camera into the USB port,
automatically mounting it as a USB storage device. I'd like similiar
functionality on my linux machine(s).

My first instinct is to look at the new input layer and see if this would
fit into that scheme.

Any thoughts, pointers, or flamage would be appreciated; i'm sub'd, but
CCs are appreciated to help seperate signal and noise.

Thanks in advance,
-- 
/jbm, but you can call me Josh. Really, you can.
 "Design may be clever in spurts,
  but evolution never sleeps"
  -- Rob Landley

