Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132562AbRDEGrR>; Thu, 5 Apr 2001 02:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132563AbRDEGrG>; Thu, 5 Apr 2001 02:47:06 -0400
Received: from mackman.submm.caltech.edu ([131.215.85.46]:28032 "EHLO
	mackman.net") by vger.kernel.org with ESMTP id <S132562AbRDEGqz>;
	Thu, 5 Apr 2001 02:46:55 -0400
Date: Wed, 4 Apr 2001 23:46:14 -0700 (PDT)
From: Ryan Mack <rmack@mackman.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [QUESTION] 2.4.3: hotplug_path unresolved in usbcore?
In-Reply-To: <Pine.LNX.4.21.0104051606440.4943-100000@brick.flying-brick.caverock.net.nz>
Message-ID: <Pine.LNX.4.30.0104042333500.2076-100000@mackman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for such a stupid question, but I'm stumped (it doesn't take much).
modprobe reports that hotplug_path is unresolved when it processes
usbcore. CONFIG_HOTPLUG is defined, so it seems that hotplug_path is
defined and EXPORTed in kernel/kmod.c, so I'm unsure what the problem is.

Thanks, Ryan

