Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbTBTKOA>; Thu, 20 Feb 2003 05:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265132AbTBTKOA>; Thu, 20 Feb 2003 05:14:00 -0500
Received: from cal003100.student.utwente.nl ([130.89.160.36]:31686 "EHLO
	margo.student.utwente.nl") by vger.kernel.org with ESMTP
	id <S265130AbTBTKN7>; Thu, 20 Feb 2003 05:13:59 -0500
Date: Thu, 20 Feb 2003 11:24:04 +0100
To: Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: 2.4.x release process comments
Message-ID: <20030220102404.GA10138@margo.student.utwente.nl>
Mail-Followup-To: simon, Kernel Maillist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Simon Oosthoek <simon@margo.student.utwente.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I'm a little worried about the support for the 2.4.x kernel series. In the
past few releases I've noticed a couple of things that I think are bad for
the kernel. 

- Kernel version releases (and -pre releases) do not happen often enough to
keep up with recent hardware

Maybe it's the contrast with the speed of releases on the 2.5.x series, but
while I understand the need for stability on the 2.4.x series, bugfixes and
hardware support should be kept up to date in the stable series as well.
Distributions need this, since every 6 months a new release is made
(mandrake, redhat, suse). If it is not kept up to date, the distros start
using 2.4.x-pre series to provide support for the most recent hardware on
which the new distros are going to be installed.

I'd love to see regular (say once a week) releases -preX releases and no
more than 10 -pre releases before a -rc. No more than 4 -rc's (released no
more than 2 weeks apart) before a new version. Faster full version releases
would also be fine with me.

- Marcello doesn't participate (much) on the kernel list

Again, not really a problem on its own, I'm sure Marcello has a lot of
things to worry about, but somehow it detracts a little from the feeling of
"trust" not to see regular posts form the kernel maintainer about bugs,
patches and how/why patches are applied/ignored.

- Alan Cox seems to provide 90% of the patches to the 2.4.x series

Obviously Alan has responsibilities for redhat, so that explains a lot.
However I get the feeling that patches for 2.4.x are more and more directed
to him rather than Marcello...

My personal interest in this is that my laptop is not yet working 100%...
(see http://margo.student.utwente.nl/simon/ongoing/jade8060.php)

BTW, I've been following the list for at least a year now (mostly via kernel
traffic and kernel releases, but now I'm subscribed)

Cheers everyone and thanks a lot for the work on the kernel!

Simon

