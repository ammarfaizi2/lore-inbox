Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbSI2Ah1>; Sat, 28 Sep 2002 20:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262357AbSI2Ah1>; Sat, 28 Sep 2002 20:37:27 -0400
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:24328 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id <S261559AbSI2Ah0>; Sat, 28 Sep 2002 20:37:26 -0400
Subject: Re: System very unstable
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020928.043427.74820153.davem@redhat.com>
References: <20020928.033510.40857147.davem@redhat.com>
	<Pine.LNX.4.44.0209280529220.7827-100000@hawkeye.luckynet.adm> 
	<20020928.043427.74820153.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 28 Sep 2002 20:42:47 -0400
Message-Id: <1033260168.742.8.camel@madmax>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-28 at 07:34, David S. Miller wrote:
> This is old news, they opensource the drivers at a later date,
> this is how it's always worked with ATI.

Note that ATI now has a binary driver available that supports the 8500,
written by their German development group.  Available via their standard
"find a driver" page, using Linux as OS.  See, for example,
http://mirror.ati.com/support/products/pc/radeon8500/linux/radeon8500linuxdrivers.html?cboOS=LinuxXFree86&cboProducts=RADEON+8500LE&cmdNext=GO%21

The scripts that build a kernel module and link it against their library
work pretty well and are, to their credit, not impossibly tied to one
distro over another.  :-)  I run Slackware.

	ktk@madmax:~$ glxgears 
	10474 frames in 5.0 seconds = 2094.800 FPS
	10797 frames in 5.0 seconds = 2159.400 FPS

Kris


