Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279891AbRKRQoH>; Sun, 18 Nov 2001 11:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279902AbRKRQn6>; Sun, 18 Nov 2001 11:43:58 -0500
Received: from femail3.sdc1.sfba.home.com ([24.0.95.83]:4777 "EHLO
	femail3.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S279891AbRKRQnt>; Sun, 18 Nov 2001 11:43:49 -0500
Date: Sun, 18 Nov 2001 11:42:26 -0500
From: Matt Cahill <m-cahill@home.com>
X-Mailer: The Bat! (v1.53d) Business
Reply-To: Matt Cahill <m-cahill@home.com>
X-Priority: 3 (Normal)
Message-ID: <1962142807.20011118114226@home.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re[2]: kernel 2.4.14 breaks NVIDIA-1.0-1541 console switching
In-Reply-To: <1006100978.891.4.camel@dwarf>
In-Reply-To: <200111171745.fAHHjnZ02112@mnlpc.dtro.e-technik.tu-darmstadt.de>
 <1006100978.891.4.camel@dwarf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  I actually just upgraded to 2.4.13 and have been experiencing this
  problem also. I get 'Waiting for X server to shutdown', forcing me
  to reboot. I reloaded the Nvidia kernel again (no problems with
  that), but the GLX driver is coughing and spitting when I try to
  reinstall it. It can't seem to find or read
  /usr/X11R6/lib/module/nvdriver.o (filename may be a little
  different...sorry, I'm in Windows right now), but it's there. This
  is also nvidia version 1541 (latest stable).

AL> Well I have the same kind of problem. But you don't have to shutdown!
AL> Just switch again to your X vt, and X should work again.

  I'm not sure I follow this... how do I switch to an X vt, and how do
  you mean 'X should work again'? Just curious if you meant this as a fix or
  a work-around.

  Thanks for any info,

  Matt Cahill
m-cahill@home.com

