Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266625AbRGEDPb>; Wed, 4 Jul 2001 23:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266621AbRGEDPV>; Wed, 4 Jul 2001 23:15:21 -0400
Received: from 24.157.217.96.on.wave.home.com ([24.157.217.96]:65291 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S266584AbRGEDPH>;
	Wed, 4 Jul 2001 23:15:07 -0400
Date: Wed, 4 Jul 2001 23:15:04 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: <bri@cs.uchicago.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Kernel HOWTO update?
Message-ID: <Pine.LNX.4.30.0107042313210.4004-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Section:
7.6 You forgot to run LILO, or system doesn't boot at all

You might want to update the following line:

"Using LILO with big drives (more than 1024 cylinders) can cause problems.
See the LILO mini-HOWTO or documentation for help on that."

This isn't true anymore unless your using an older version of LILO.

Shawn.

