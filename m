Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbUCYRQC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbUCYRNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:13:50 -0500
Received: from virt-216-40-198-21.ev1servers.net ([216.40.198.21]:8966 "EHLO
	virt-216-40-198-21.ev1servers.net") by vger.kernel.org with ESMTP
	id S263484AbUCYRNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 12:13:09 -0500
Date: Thu, 25 Mar 2004 11:12:58 -0600
From: Chuck Campbell <campbell@accelinc.com>
To: linux-kernel@vger.kernel.org
Subject: laptop issues: is there a driver for gigabyte wireless?
Message-ID: <20040325171258.GA19535@helium.inexs.com>
Mail-Followup-To: Chuck Campbell <campbell@accelinc.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm contemplating a prostar laptop (8794 model).  As far as I can tell
everything should work fine, except I don't know about the 802.11g wireless,
which is Gigabyte GN-WIAG.

Anyone know if this device will work under any 2.4 or 2.6 kernels?
I got no hits on the kernel mailing list archive, so maybe someone knows
more about it.

If you know of any other issues with other h/w in this laptop, I'd appreciate
hearing about it.

ATI Radeon 9700 
  Should work, w/o acceleration, right?  If not, I need to know ASAP

Promise PDC20265R raid controller 
  If raid doesn't work, it's not a problem, as long as I can see the disks.
  I saw some stuff about "lost interrupt hell" on the lkml archives, but
  nothing definitive.  Also all old.

3D Realtek sound ALC650 Codec 2.2
  I see recent ALSA updates for this under 2.6, so I assume I'm fine here.

thanks,
-chuck
