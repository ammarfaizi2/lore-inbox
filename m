Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279462AbRKXTgB>; Sat, 24 Nov 2001 14:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279617AbRKXTfv>; Sat, 24 Nov 2001 14:35:51 -0500
Received: from [212.18.232.186] ([212.18.232.186]:17156 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S279462AbRKXTfg>; Sat, 24 Nov 2001 14:35:36 -0500
Date: Sat, 24 Nov 2001 19:34:49 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Phil Sorber <aafes@psu.edu>
Cc: Andrea Arcangeli <andrea@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.15aa1
Message-ID: <20011124193449.A13602@flint.arm.linux.org.uk>
In-Reply-To: <20011124085028.C1419@athlon.random> <1006629351.1470.8.camel@praetorian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1006629351.1470.8.camel@praetorian>; from aafes@psu.edu on Sat, Nov 24, 2001 at 02:15:50PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 02:15:50PM -0500, Phil Sorber wrote:
> Is this the problem that Al put out a patch for yesterday? And is his
> patch been tested and working?

I'm running it 2.4.15-viro three systems here with no detectable problems.
One has been building lots of kernels, the other has been sitting rather
idle, except for the occasional redhat package build, and has been rebooted
a few times.  These are using a mixture of ext2 and NFS.

The last system is my firewall, which I don't expect to show any problems
with or without Al's fix, since it's running completely diskless (ie, NFS).

Naturally, they're all ARM boxen.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

