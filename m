Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286904AbSABJf0>; Wed, 2 Jan 2002 04:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286893AbSABJfI>; Wed, 2 Jan 2002 04:35:08 -0500
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:7235 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S286815AbSABJer>; Wed, 2 Jan 2002 04:34:47 -0500
From: brian@worldcontrol.com
Date: Wed, 2 Jan 2002 01:33:05 -0800
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.17 vs 2.2.19 vs rml new VM
Message-ID: <20020102013305.A5272@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to say that as of 2.4.17 w/preempt patch, the linux kernel
seems again to perform as well as 2.2.19 for interactive use and
reliability, at least in my use.

2.4.17 still croaks running some of the giant memory applications
that I run successfully on 2.2.19. (Machines with 2GB of RAM 
running 3GB+ apps.)

I tried rmap-10 new VM and under my typical load my desktop machine
froze repeatedly.  Seemed the memory pool was going down the drain
before the freeze. Meaning apps were failing and getting stuck in
various odd states.

No doubt, preempt and rmap-10 are incompatible, but I'm not going to
give up the preempt patch any time soon.

All in all 2.4.17 w/preempt is very satisfactory.

-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2002 By Brian Litzinger, All Rights Reserved
