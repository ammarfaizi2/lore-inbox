Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132774AbRDDJF4>; Wed, 4 Apr 2001 05:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132776AbRDDJFg>; Wed, 4 Apr 2001 05:05:36 -0400
Received: from four.malevolentminds.com ([216.177.76.238]:47629 "EHLO
	four.malevolentminds.com") by vger.kernel.org with ESMTP
	id <S132774AbRDDJF1>; Wed, 4 Apr 2001 05:05:27 -0400
Date: Wed, 4 Apr 2001 02:04:40 -0700 (PDT)
From: Khyron <khyron@khyron.com>
X-X-Sender: <khyron@four.malevolentminds.com>
To: <linux-kernel@vger.kernel.org>
Subject: loopback mount won't umount on 2.2.12
Message-ID: <Pine.BSF.4.33.0104040200340.86240-100000@four.malevolentminds.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I've seen various references to problems with loopback
mounts under (early) 2.2.x kernels. But I don't see any reference
to a solution (ie. how to umount the stupid thing).

My situation is that I have mounted a CD image on a machine
for use in kickstart builds. The mount point is /kickstart/image

When I attempt "umount /kickstart/image" and other variations
on the theme, I get a "umount: /kickstart/image: device is busy".

Is there ANYWAY (w/o rebooting) to unmount this, forcibly or
otherwise? Or is the solution only to reboot?

TIA!

////////////////////////////////////////////////////////////////////
Khyron					    mailto:khyron@khyron.com
Key fingerprint = 53BB 08CA 6A4B 8AF8 DF9B  7E71 2D20 AD30 6684 E82D
			"Drama free in 2001!"
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

