Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbTBTKsl>; Thu, 20 Feb 2003 05:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbTBTKsl>; Thu, 20 Feb 2003 05:48:41 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:21509 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S262838AbTBTKsk>; Thu, 20 Feb 2003 05:48:40 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302201056.h1KAuwui000635@81-2-122-30.bradfords.org.uk>
Subject: Re: 2.4.x release process comments
To: simon@cal003100.student.utwente.nl (Simon Oosthoek)
Date: Thu, 20 Feb 2003 10:56:58 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030220102404.GA10138@margo.student.utwente.nl> from "Simon Oosthoek" at Feb 20, 2003 11:24:04 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Kernel version releases (and -pre releases) do not happen often enough to
> keep up with recent hardware
> 
> Maybe it's the contrast with the speed of releases on the 2.5.x series, but
> while I understand the need for stability on the 2.4.x series, bugfixes and
> hardware support should be kept up to date in the stable series as well.
> Distributions need this, since every 6 months a new release is made
> (mandrake, redhat, suse). If it is not kept up to date, the distros start
> using 2.4.x-pre series to provide support for the most recent hardware on
> which the new distros are going to be installed.

Distributions typically use modified versions of the standard kernel
anyway.  The kernel development schedule has never been based around
the needs of any particular distribution or distributions.

> I'd love to see regular (say once a week) releases -preX releases and no
> more than 10 -pre releases before a -rc. No more than 4 -rc's (released no
> more than 2 weeks apart) before a new version. Faster full version releases
> would also be fine with me.

It doesn't make sense to limit the number of -pre releases and release
candidates - they are needed to make sure, as far as possible, that
the actual release is stable.

> - Marcello doesn't participate (much) on the kernel list
> 
> - Alan Cox seems to provide 90% of the patches to the 2.4.x series
> 
> However I get the feeling that patches for 2.4.x are more and more directed
> to him rather than Marcello...

I don't see a problem with this, (although we shouldn't just be lazy,
and send all patches to Alan when there are more appropriate people).

Just because somebody is maintaining a subsystem or kernel tree, does
not mean that they have to do the most work, or that nobody else is
expected to edit that code.

> My personal interest in this is that my laptop is not yet working 100%...
> (see http://margo.student.utwente.nl/simon/ongoing/jade8060.php)

I had a quick look, and it looks like it's 95% working, though :-).

John.
