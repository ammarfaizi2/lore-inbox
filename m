Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131270AbRBVHtR>; Thu, 22 Feb 2001 02:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131286AbRBVHtH>; Thu, 22 Feb 2001 02:49:07 -0500
Received: from dalbosrv3.araby-dalbo.com ([195.67.33.199]:62980 "HELO
	araby-dalbo.com") by vger.kernel.org with SMTP id <S131270AbRBVHs7>;
	Thu, 22 Feb 2001 02:48:59 -0500
Message-ID: <3A94C553.FC4C6F30@araby-dalbo.com>
Date: Thu, 22 Feb 2001 08:52:51 +0100
From: Reine Johansson <brain@araby-dalbo.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: SB-driver in 2.4.x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MDRemoteIP: 10.1.254.50
X-Return-Path: brain@araby-dalbo.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The SoundBlaster driver havn't been working in any of the 2.4.x-releases if I
compile it into the kernel. However, it does work when compiled as a module. It
worked ok for me both compiled in and as a module under 2.2.x

I have sb=220,7,1,5 at the kernel commandline (the right values). The kernel
prints

Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996

at boot, and nothing more.

TIA

PS. I'm not subscribed.

