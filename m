Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135881AbRD2Syj>; Sun, 29 Apr 2001 14:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135880AbRD2Sy3>; Sun, 29 Apr 2001 14:54:29 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:3845 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S135825AbRD2SyV>;
	Sun, 29 Apr 2001 14:54:21 -0400
Date: Sun, 29 Apr 2001 01:42:42 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Michael K. Johnson" <johnsonm@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lid support for ACPI
Message-ID: <20010429014241.B32@(none)>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDDC9@orsmsx35.jf.intel.com> <200104271708.f3RH8Yv02001@bastable.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200104271708.f3RH8Yv02001@bastable.devel.redhat.com>; from johnsonm@redhat.com on Fri, Apr 27, 2001 at 01:08:34PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >PS: This seems very strange. What if machine is so crashed so that it
> >can no longer shutdown properly. Will that mean that its CPU will
> >damage itself?
> 
> No, the ACPI standard requires CPUs to shut themselves down before
> any damage would occur from overheading.  Well, at least the 1.0b
> version of the standard did; I haven't read 2.0 yet.

BTW shut themselves down to halt, or shut themselves to *very* low speed?
Slow down to 10% speed is what my toshiba does. Is there way back from such
mode?
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

